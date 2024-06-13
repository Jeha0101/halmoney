import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/AI_select_cond_page.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';

class CondSearchResultPage extends StatelessWidget {
  final List<DocumentSnapshot> jobs;
  const CondSearchResultPage({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    print('CondSearchResultPage ${jobs.length} jobs');
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
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: jobs.map((job) => Cond_Search(job: job)).toList(),
            )),
      ),
    );
  }
}

class Cond_Search extends StatelessWidget {
  final DocumentSnapshot job;
  const Cond_Search({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> jobData = job.data() as Map<String, dynamic>;
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Recruit_main(
            id: jobData['id'],
            num: jobData['num'],
              title: jobData['title'],
              address: jobData['address'],
              wage: jobData['wage'],
              career: jobData['job_name'],
              detail: jobData['detail'],
              workweek: jobData['work_time_week'],
              image_path: jobData['image_path'],
              //userId: widget.id,
          )),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: SizedBox(
        width: 370,
        height: 100,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              width: 100,
              height: 100,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/songpa.png",
                    width: 90,
                    height: 90,
                  )
                ],
              ),
            ),
            const SizedBox(width: 15),
            Container(
              width: 200,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            jobData['job_name'] ?? '',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                              jobData['address'] ?? '',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(250, 69, 99, 255)),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            jobData['wage'] ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
