import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'cond_search_result_page.dart';
import 'resume_recommd_ListPage.dart';

class AIRecommenPage extends StatefulWidget {
  final String id;
  final String interestPlace; // 관심 지역
  final List<String> interestWork; // 관심 분야 목록

  const AIRecommenPage({
    super.key,
    required this.id,
    required this.interestPlace,
    required this.interestWork,
  });

  @override
  _AIRecommPage createState() => _AIRecommPage();
}

class _AIRecommPage extends State<AIRecommenPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> recommendedJobs = []; // 추천된 공고 목록
  List<DocumentSnapshot> allJobs = []; // 모든 공고 목록
  bool isLoading = true; // 로딩 상태 플래그

  @override
  void initState() {
    super.initState();
    fetchAllJobs(); // 초기 데이터 가져오기
  }

  // 모든 공고 데이터를 Firestore에서 가져오는 함수
  Future<void> fetchAllJobs() async {
    try {
      // 모든 공고 가져오기
      final QuerySnapshot jobSnapshot = await _firestore.collection('jobs').get();
      setState(() {
        allJobs = jobSnapshot.docs;
      });
      computeRecommendations(); // 추천 계산 함수 호출
    } catch (error) {
      print("Failed to fetch all jobs: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch all jobs: $error")),
      );
    }
  }

  // 추천 계산 함수
  void computeRecommendations() {
    List<Map<String, dynamic>> recommendations = [];

    for (var jobDoc in allJobs) {
      final job = jobDoc.data() as Map<String, dynamic>;
      final String jobTitle = job['title'] ?? '';
      final String jobAddress = job['address'] ?? '';

      int similarityScore = 0;

      // 관심 분야와 일치하는 경우 유사도 점수 증가
      for (String field in widget.interestWork) {
        if (jobTitle.contains(field)) {
          similarityScore += 5;
          break; // 관심 분야와 일치하면 더 이상의 반복을 피함
        }
      }

      // 관심 지역과 일치하는 경우 유사도 점수 증가
      if (jobAddress.contains(widget.interestPlace)) {
        similarityScore += 3;
      }

      if (similarityScore > 0) {
        recommendations.add({
          'job': jobDoc,
          'similarity_score': similarityScore
        });
      }
    }

    // 유사도 점수를 기준으로 공고 정렬
    recommendations.sort((a, b) => b['similarity_score'].compareTo(a['similarity_score']));

    // 상위 15개 공고만 선택
    final topRecommendations = recommendations.take(15).toList();

    setState(() {
      recommendedJobs = topRecommendations.map((r) => r['job'] as DocumentSnapshot).toList();
      isLoading = false;
    });

    // 이동할 때 filtered job list를 넘김
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Recommen_Component(jobs: recommendedJobs),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(),
    );
  }
}