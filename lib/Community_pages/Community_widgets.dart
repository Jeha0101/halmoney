import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/Community_pages/Community_detail_page.dart';
import 'package:intl/intl.dart';

class Community_widget extends StatefulWidget {
  final String id;
  final String title;
  final String contents;
  final Timestamp timestamp;

  const Community_widget({
    required this.id,
    required this.title,
    required this.contents,
    required this.timestamp,
    super.key,
  });

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community_widget> {
  @override


  Widget build(BuildContext context) {

    // Timestamp를 DateTime으로 변환
    DateTime date = widget.timestamp.toDate();
    // 원하는 형식으로 변환
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  CommunityDetail(
            id: widget.id,
            title: widget.title,
            contents: widget.contents,

          )),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            color: Color.fromARGB(255, 217, 217, 217), // 버튼의 테두리 색상
            width: 1.0, // 버튼의 테두리 두께
          ),
        ),
      ),
      child: Container(
        height: 119,
        width: 420,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(500, 217, 217, 217), // 라인 색상
              width: 1.0, // 라인 두께
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.contents,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
            // 다른 내용을 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
