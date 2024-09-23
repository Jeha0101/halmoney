import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicJobsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPublicJobs() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('public_jobs').get();
      List<Map<String, dynamic>> jobs = snapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'company': doc['company'],
          'region': doc['region'],
          'image_path': doc['image_path'],
          'endday': doc['endday'],
        };
      }).toList();
      return jobs;
    } catch (e) {
      print("Failed to fetch jobs: $e");
      return [];
    }
  }
}
