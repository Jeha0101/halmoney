import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:halmoney/myAppPage.dart';
import 'PublicJobsList_widget.dart';

class PublicJobsDescribe extends StatefulWidget {
  final String id;
  const PublicJobsDescribe({super.key, required this.id});

  @override
  _PublicJobsDescribeState createState() => _PublicJobsDescribeState();
}

class _PublicJobsDescribeState extends State<PublicJobsDescribe> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> jobs = [];
  String? userDocId;
  List<String> userLikes = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchPublicJobs();
  }

  Future<void> _fetchPublicJobs() async {
    try {
      final QuerySnapshot result = await _firestore.collection('publicjobs').get();
      final List<DocumentSnapshot> documents = result.docs;

      setState(() {
        jobs = documents.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          // Convert the Timestamp to a DateTime object and then to a formatted string
          String endDayStr = 'No end_day';
          if (data['end_day'] != null) {
            DateTime endDay = (data['end_day'] as Timestamp).toDate();
            endDayStr = DateFormat('yyyy-MM-dd').format(endDay); // Format the DateTime
          }

          return {
            'num': data['num'] ?? 0,
            'title': data['jobtitle'] ?? 'No Title.',
            'company': data['hirecompany'] ?? 'No company',
            'region': data['hireregion'] ?? 'No address',
            'type': data['hiretype'] ?? 'No type',
            'url': data['hireurl'] ?? 'No url',
            'person': data['applyperson'] ?? 'No person',
            'person2': data['applyperson2'] ?? 'No person2',
            'personcareer': data['applypersoncareer'] ?? 'No person career',
            'personedu': data['applypersonedu'] ?? 'No person edu',
            'applystep': data['applystep'] ?? 'No apply step',
            'image_path': data['image_path'] ?? 'No_path',
            'isLiked': userLikes.contains(data['num'].toString()),
            'end_day': endDayStr,
          };
        }).toList();
        print('공공일자리 공고들! $jobs');
      });
    } catch (error) {
      print("Failed to fetch jobs: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch jobs: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('공공일자리 리스트'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(250, 51, 51, 255),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppPage(id: widget.id)),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.grey,
            ),
          ),
          body: jobs.isEmpty
              ? const Center(child: Text('No jobs available'))
              : ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PublicJobList(
                  id: widget.id,
                  num: job['num'],
                  title: job['title'],
                  company: job['company'],
                  region: job['region'],
                  type: job['type'],
                  url: job['url'],
                  person: job['person'],
                  person2: job['person2'],
                  personcareer: job['personcareer'],
                  personedu: job['personedu'],
                  applystep: job['applystep'],
                  image_path: job['image_path'],
                  isLiked: job['isLiked'],
                  endday: job['end_day'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}