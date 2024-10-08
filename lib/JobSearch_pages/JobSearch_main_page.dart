import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/JobSearch_pages/JobList_widget.dart';
import 'package:halmoney/myAppPage.dart';
import 'package:intl/intl.dart';

class JobSearch extends StatefulWidget {
  final String id;
  const JobSearch({super.key, required this.id});

  @override
  _JobSearchState createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
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
    await _fetchUserLikes();
    await _fetchJobs();
  }

  Future<void> _fetchUserLikes() async {
    try {
      // Fetch the user document based on the provided widget.id
      final QuerySnapshot userQuery = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Assuming there is only one user document matching the id
        final String userId = userQuery.docs.first.id;
        userDocId = userId;

        // Fetch the user's likes sub-collection
        final QuerySnapshot userLikesQuery = await _firestore
            .collection('user')
            .doc(userId)
            .collection('users_like')
            .get();

        // Extract the 'num' field from each document, if it exists
        setState(() {
          userLikes = userLikesQuery.docs
              .where((doc) => (doc.data() as Map<String, dynamic>).containsKey('num'))
              .map((doc) => doc['num'].toString())
              .toList();
        });
        print('---------------------------');
        print(userLikes);
      } else {
        print("No user found with the provided id.");
      }
    } catch (error) {
      print("Failed to fetch user likes!: $error");
    }
  }

  Future<void> _fetchJobs() async {
    try {
      final QuerySnapshot result = await _firestore.collection('jobs').get();
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
            'title': data['title'] ?? 'No Title.',
            'address': data['address'] ?? 'No address',
            'wage': data['wage'] ?? 'No Wage',
            'career': data['career'] ?? 'No Career',
            'detail': data['detail'] ?? 'No detail',
            'workweek': data['work_time_week'] ?? 'No work Week',
            'image_path': data['image_path'] ?? 'No_path',
            'isLiked': userLikes.contains(data['num'].toString()),
            'end_day': endDayStr,
          };
        }).toList();
        print('공고들! $jobs');
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
            title: const Text('공고리스트'),
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
              ? const  Center(child: Text('No jobs available'))
              : ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: JobList(
                  id: widget.id,
                  num: job['num'],
                  title: job['title'],
                  address: job['address'],
                  wage: job['wage'],
                  career: job['career'],
                  detail: job['detail'],
                  workweek: job['workweek'],
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