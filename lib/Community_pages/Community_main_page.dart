import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/Community_pages/Community_widgets.dart';
import 'package:halmoney/Community_pages/Community_write_page.dart';
class Communitypage extends StatefulWidget {
  final String id;
  const Communitypage({super.key, required this.id});

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Communitypage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> writings = [];

  @override
  void initState() {
    super.initState();
    _fetchCommunity();
  }
  Future<void> _fetchCommunity() async {
    try {
      final QuerySnapshot result = await _firestore.collection('community').get();
      final List<DocumentSnapshot> documents = result.docs;


      setState(() {
        writings = documents.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'title': data['title']??'No title',
            'contents': data['contents']??'No contents',
            'timestamp': data['timestamp'] as Timestamp,
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
          Theme
              .of(context)
              .textTheme,
        ),
      ),

      home: SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('커뮤니티'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Stack(
            children: [
             ListView.builder(
               itemCount: writings.length,
               itemBuilder:(context,index){
                 final writing = writings[index];
                 return Column(
                   children: [
                   Community_widget(id: widget.id,
                   title: writing['title'],
                   contents: writing['contents'],
                   timestamp: writing['timestamp'],
                 ),
                     SizedBox(height:10)
                   ],
                 );
               },
             ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Community_Write()),
                    );
                  },
                  backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
