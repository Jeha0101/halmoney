import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';

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
  List<Map<String, dynamic>> recommendedJobs = []; // 추천된 공고 목록
  List<Map<String, dynamic>> allJobs = []; // 모든 공고 목록
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
        final interestWorkData = interestWorkSnapshot.data() as Map<String, dynamic>?;
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
        final interestPlaceData = interestPlaceSnapshot.data() as Map<String, dynamic>?;
        if (interestPlaceData != null) {
          setState(() {
            interestPlace = interestPlaceData['inter_place'];
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

        // 사용자가 찜한 공고 목록 가져오기
        final likedJobsSnapshot = await _firestore
            .collection('user')
            .doc(docId)
            .collection('users_like')
            .get();
        setState(() {
          likedJobs = likedJobsSnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'job_title': data['job_title']
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
        allJobs = jobSnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['doc_id'] = doc.id; // 문서 ID를 데이터에 포함시키기
          return data;
        }).toList();
      });
    } catch (error) {
      print("Failed to fetch all jobs: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch all jobs: $error")),
      );
    }
  }

  // 추천 계산 함수
  void computeRecommendations() {
    // 사용자의 관심 분야와 찜한 공고 제목을 하나의 프로파일로 합치기
    List<String> userProfile = List.from(interestWork);
    userProfile.addAll(likedJobs.map<String>((job) => job['job_title'] as String).toList());

    // 공고 목록과 사용자의 프로파일을 비교하여 유사도 점수 계산
    final List<Map<String, dynamic>> recommendations = [];
    for (var job in allJobs) {
      final String jobTitle = job['title'] ?? '';
      final String jobDescription = job['description'] ?? '';
      final String jobAddress = job['address'] ?? '';

      // 공고 제목과 설명을 합쳐서 유사도 계산
      final List<String> jobKeywords = (jobTitle + ' ' + jobDescription).split(' ');

      // 사용자 프로파일과 공고 키워드의 겹치는 개수를 유사도 점수로 사용
      int similarityScore = userProfile.fold(0, (prev, keyword) => prev + (jobKeywords.contains(keyword) ? 1 : 0));

      // 관심 지역과 공고 지역이 일치하면 유사도 점수 증가
      if (jobAddress.contains(interestPlace)) {
        similarityScore += 1;
      }

      job['similarity_score'] = similarityScore;
      recommendations.add(job);
    }

    // 유사도 점수를 기준으로 공고 정렬
    recommendations.sort((a, b) => b['similarity_score'].compareTo(a['similarity_score']));

    setState(() {
      recommendedJobs = recommendations;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 51, 51, 255),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: recommendedJobs.length,
        itemBuilder: (context, index) {
          final job = recommendedJobs[index];
          return ListTile(
            title: Text(job['title']),
            subtitle: Text("${job['address']} - ${job['category']}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Recruit_main(
                    id: job['id'],
                    num: job['num'],
                    title: job['title'],
                    address: job['address'],
                    wage: job['wage'],
                    career: job['career'],
                    detail: job['detail'],
                    workweek: job['workweek'],
                    image_path: job['image_path'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
