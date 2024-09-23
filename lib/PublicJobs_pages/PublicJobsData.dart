import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicJobsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPublicJobs() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('publicjobs').get();
      List<Map<String, dynamic>> jobs = snapshot.docs.map((doc) {
        return {
          'title': doc['jobtitle'],
          'company': doc['hirecompany'],
          'region': doc['hireregion'],
          'image_path': doc['image_path'],
          'endday': doc['end_day'],
        };
      }).toList();
      return jobs;
    } catch (e) {
      print("Failed to fetch jobs: $e");
      return [];
    }
  }
}
