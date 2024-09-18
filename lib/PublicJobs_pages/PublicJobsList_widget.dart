import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PublicJobsDetail.main.dart';

class PublicJobList extends StatefulWidget {
  final String id;
  final int num;
  final String title;
  final String company;
  final String region;
  final String type;
  final String url;
  final String person;
  final String person2;
  final String personcareer;
  final String personedu;
  final String applystep;
  final bool isLiked;
  final String image_path;
  final String endday;

  const PublicJobList({
    required this.id,
    required this.num,
    required this.title,
    required this.company,
    required this.region,
    required this.type,
    required this.url,
    required this.person,
    required this.person2,
    required this.personcareer,
    required this.personedu,
    required this.applystep,
    required this.isLiked,
    required this.image_path,
    required this.endday,
    Key? key,
  }) : super(key: key);

  @override
  _PublicJobListState createState() => _PublicJobListState();
}

class _PublicJobListState extends State<PublicJobList> {
  late bool isFavorite;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isLiked;
  }

  Future<void> _saveViewedJob() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();
      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;
        final viewedJobsRef = _firestore
            .collection('user')
            .doc(docId)
            .collection('viewed_jobs')
            .doc();

        await viewedJobsRef.set({
          'job_title': widget.title,
          'viewed_at': Timestamp.now(),
        });
      } else {
        print('User document ID is empty.');
      }
    } catch (error) {
      print('Failed to save job viewing history: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child:ElevatedButton(
        onPressed: () {
          _saveViewedJob();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PublicJobsDetail(
                id: widget.id,
                num: widget.num,
                title: widget.title,
                company: widget.company,
                region: widget.region,
                type: widget.type,
                url: widget.url,
                person: widget.person,
                person2: widget.person2,
                personcareer: widget.personcareer,
                personedu: widget.personedu,
                applystep: widget.applystep,
                endday: widget.endday,
                image_path: widget.image_path,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Applying border radius
                  ),
                  child: Image.asset(
                    widget.image_path,

                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.company,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(250, 69, 99, 255),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.region,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 0, 0, 128),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '마감일: ${widget.endday}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );

  }
}