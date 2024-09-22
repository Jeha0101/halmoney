import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<List<DocumentSnapshot>> fetchRecommendations({
  required String interestPlace,
  required List<String> interestWork,
}) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> recommendedJobs = [];

  try {
    // 모든 공고 가져오기
    final QuerySnapshot jobSnapshot = await _firestore.collection('jobs').get();
    final List<DocumentSnapshot> allJobs = jobSnapshot.docs;

    print('관심 지역: $interestPlace');
    print('관심 분야: $interestWork');

    List<Map<String, dynamic>> recommendations = [];

    for (var jobDoc in allJobs) {

      // jobDoc.data()는 nullable이므로 null 체크 필요
      final jobData = jobDoc.data() as Map<String, dynamic>?;

      if (jobData == null) {
        // 데이터가 null일 경우 건너뛰기
        continue;
      }

      final String jobTitle = jobData['title'] ?? '';
      final String jobAddress = jobData['address'] ?? '';

      print(jobTitle);
      print(jobAddress);

      int similarityScore = 0;

      // 관심 분야와 일치하는 경우 유사도 점수 증가
      for (String field in interestWork) {
        if (jobTitle.contains(field)) {
          similarityScore += 5;
          break;
        }
      }

      // 관심 지역과 일치하는 경우 유사도 점수 증가
      if (jobAddress.contains(interestPlace)) {
        similarityScore += 7;
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

    // 상위 7개 공고만 선택
    recommendedJobs = recommendations.take(7).map((r) => r['job'] as DocumentSnapshot).toList();
    print('함수에서 호출 $recommendedJobs');
  } catch (error) {
    print("Failed to fetch jobs: $error");
    // 예외 처리 추가 가능
  }

  return recommendedJobs;
}