import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'cond_search_result_page.dart';

class AIRecommPage extends StatefulWidget {
  final String id;
  const AIRecommPage({super.key, required this.id});

  @override
  _AIRecommPage createState() => _AIRecommPage();
}

class _AIRecommPage extends State<AIRecommPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String interestPlace = ''; // 사용자의 관심 지역
  List<String> interestWork = []; // 사용자의 관심 분야 목록
  List<Map<String, dynamic>> viewedJobs = []; // 사용자가 본 공고 목록
  List<Map<String, dynamic>> likedJobs = []; // 사용자가 찜한 공고 목록
  List<DocumentSnapshot> recommendedJobs = []; // 추천된 공고 목록
  List<DocumentSnapshot> allJobs = []; // 모든 공고 목록
  bool isLoading = true; // 로딩 상태 플래그

  @override
  void initState() {
    super.initState();
    fetchUserData(); // 초기 데이터 가져오기
  }

  // 사용자 데이터를 Firestore에서 가져오는 함수
  Future<void> fetchUserData() async {
    try {
      // 사용자의 ID로 Firestore에서 사용자 문서 가져오기
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();
      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        // 관심 분야 가져오기
        final interestWorkSnapshot = await _firestore
            .collection('user')
            .doc(docId)
            .collection('Interest')
            .doc('interests_work')
            .get();
        final interestWorkData = interestWorkSnapshot.data();
        if (interestWorkData != null) {
          setState(() {
            interestWork = List<String>.from(interestWorkData['int_work']);
          });
        }

        // 관심 지역 가져오기
        final interestPlaceSnapshot = await _firestore
            .collection('user')
            .doc(docId)
            .collection('Interest')
            .doc('interest_place')
            .get();
        final interestPlaceData = interestPlaceSnapshot.data();
        if (interestPlaceData != null) {
          setState(() {
            String place = interestPlaceData['inter_place'];
            var placeparts = place.split('>');
            interestPlace = placeparts.length > 1 ? placeparts[1].trim():'';
          });
        }

        // 사용자가 본 공고 목록 가져오기
        final viewedJobsSnapshot = await _firestore
            .collection('user')
            .doc(docId)
            .collection('viewed_jobs')
            .get();
        setState(() {
          viewedJobs = viewedJobsSnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'job_title': data['job_title'],
              'viewed_at': data['viewed_at']
            };
          }).toList();
        });


        // 모든 공고 가져오기 및 추천 계산
        await fetchAllJobs();
        computeRecommendations();
      }
    } catch (error) {
      print("Failed to fetch user data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch user data: $error")),
      );
    }
  }

  // 모든 공고 데이터를 Firestore에서 가져오는 함수
  Future<void> fetchAllJobs() async {
    try {
      // 모든 공고 가져오기
      final QuerySnapshot jobSnapshot = await _firestore.collection('jobs').get();
      setState(() {
        allJobs = jobSnapshot.docs;
      });
    } catch (error) {
      print("Failed to fetch all jobs: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch all jobs: $error")),
      );
    }
  }

  // TF-IDF 계산을 위한 함수
  Map<String, double> computeTF(String document, List<String> corpus) {
    Map<String, double> tf = {};
    List<String> words = document.split(' ');

    for (String word in words) {
      tf[word] = (tf[word] ?? 0) + 1;
    }

    for (String word in tf.keys) {
      tf[word] = tf[word]! / words.length;
    }
    return tf;
  }

  Map<String, double> computeIDF(List<String> corpus) {
    Map<String, double> idf = {};
    int totalDocuments = corpus.length;

    for (String document in corpus) {
      List<String> words = document.split(' ').toSet().toList();
      for (String word in words) {
        idf[word] = (idf[word] ?? 0) + 1;
      }
    }

    for (String word in idf.keys) {
      idf[word] = log(totalDocuments / (idf[word]!));
    }

    return idf;
  }

  Map<String, double> computeTFIDF(String document, List<String> corpus) {
    Map<String, double> tf = computeTF(document, corpus);
    Map<String, double> idf = computeIDF(corpus);

    Map<String, double> tfidf = {};
    for (String word in tf.keys) {
      tfidf[word] = tf[word]! * idf[word]!;
    }

    return tfidf;
  }

  double cosineSimilarity(Map<String, double> vec1, Map<String, double> vec2) {
    double dotProduct = 0.0;
    double magnitude1 = 0.0;
    double magnitude2 = 0.0;

    for (String key in vec1.keys) {
      dotProduct += vec1[key]! * (vec2[key] ?? 0);
      magnitude1 += pow(vec1[key]!, 2);
    }

    for (String key in vec2.keys) {
      magnitude2 += pow(vec2[key]!, 2);
    }

    magnitude1 = sqrt(magnitude1);
    magnitude2 = sqrt(magnitude2);

    if (magnitude1 != 0.0 && magnitude2 != 0.0) {
      return dotProduct / (magnitude1 * magnitude2);
    } else {
      return 0.0;
    }
  }


  // 추천 계산 함수
  void computeRecommendations() {
    // 사용자의 관심 분야와 열람한 공고 제목을 하나의 프로파일로 합치기
    List<String> userProfile = List.from(interestWork);
    userProfile.addAll(viewedJobs.map<String>((job) => job['job_title']).toList());
    String userProfileStr = userProfile.join(' ');

    print("User Profile: $userProfile");

    /*// 공고 목록과 사용자의 프로파일을 비교하여 유사도 점수 계산
    final List<Map<String, dynamic>> recommendations = [];
    for (var jobDoc in allJobs) {
      final job = jobDoc.data() as Map<String, dynamic>;
      final String jobTitle = job['title'] ?? '';
      final String jobDescription = job['detail'] ?? '';
      final String jobAddress = job['address'] ?? '';

      // 공고 제목과 설명을 합쳐서 유사도 계산
      final List<String> jobKeywords = ('$jobTitle $jobDescription').split(' ');
      // 공고 키워드 출력
      print("Job Keywords for '$jobTitle': $jobKeywords");

      // 사용자 프로파일과 공고 키워드의 겹치는 개수를 유사도 점수로 사용
      int similarityScore = userProfile.fold(0, (prev, keyword) => prev + (jobKeywords.contains(keyword) ? 2 : 0));

      // 관심 지역과 공고 지역이 일치하면 유사도 점수 증가
      if (jobAddress.contains(interestPlace)) {
        similarityScore += 3;
      }*/

    List<String> jobDescriptions = allJobs.map<String>((jobDoc) {
        final job = jobDoc.data() as Map<String, dynamic>;
        return '${job['title'] ?? ''} ${job['detail'] ?? ''}';
      }).toList();

    List<Map<String, dynamic>> recommendations = [];

    Map<String, double> userProfileTFIDF = computeTFIDF(userProfileStr, jobDescriptions + [userProfileStr]);

    for (int i = 0; i < allJobs.length; i++) {
        final jobDoc = allJobs[i];
        final job = jobDoc.data() as Map<String, dynamic>;
        String jobDesc = '${job['title'] ?? ''} ${job['detail'] ?? ''}';
        Map<String, double> jobTFIDF = computeTFIDF(jobDesc, jobDescriptions + [userProfileStr]);

        double similarityScore = cosineSimilarity(userProfileTFIDF, jobTFIDF);
        if (job['address'].contains(interestPlace)) {
          similarityScore += 0.3; // 관심 지역에 일치하는 경우 점수를 약간 증가시킴
        }

        job['similarity_score'] = similarityScore;
      recommendations.add({
        'job': jobDoc,
        'similarity_score': similarityScore
      });
    }

    // 유사도 점수를 기준으로 공고 정렬
    recommendations.sort((a, b) => b['similarity_score'].compareTo(a['similarity_score']));

    // 상위 15개 공고만 선택
    final topRecommendations = recommendations.take(15).toList();

    // 상위 15개 공고의 유사도 점수 출력
    print("Top 15 Recommendations:");
    for (var recommendation in topRecommendations) {
      final job = recommendation['job'] as DocumentSnapshot;
      final jobData = job.data() as Map<String, dynamic>;
      print("Job: ${jobData['title']}, Similarity Score: ${recommendation['similarity_score']}");
    }

    setState(() {
      recommendedJobs = topRecommendations.map((r) => r['job'] as DocumentSnapshot).toList();
      isLoading = false;
    });

    // 이동할 때 filtered job list를 넘김
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CondSearchResultPage(jobs: recommendedJobs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
        elevation: 1.0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/img_logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                '할MONEY',
                style: TextStyle(
                  fontFamily: 'NanumGothicFamily',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Container(),
    );
  }
}
