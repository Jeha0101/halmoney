import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/JobSearch_pages/JobList_widget.dart';

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
          return {
            'num': data['num'] ?? 0,
            'title': data['title'] ?? 'No Title.',
            'address': data['address'] ?? 'No address',
            'wage': data['wage'] ?? 'No Wage',
            'career': data['career'] ?? 'No Career',
            'detail': data['detail'] ?? 'No detail',
            'workweek': data['work_time_week'] ?? 'No work Week',
            'isLiked': userLikes.contains(data['num'].toString())
          };
        }).toList();
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
            backgroundColor: Color.fromARGB(250, 51, 51, 255),
            elevation: 1.0,
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.grey,
                ),
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
          body: jobs.isEmpty
              ? const Center(child: CircularProgressIndicator())
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
                  isLiked: job['isLiked'],
                  userDocId: userDocId ?? '',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
