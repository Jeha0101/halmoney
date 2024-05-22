import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';
import 'package:halmoney/Community_pages/Community_detail_page.dart';

class Community_comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: 420,
      decoration: BoxDecoration(
     
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(500, 217, 217, 217), // 라인 색상
            width: 1.0,
            // 라인 두께
          ),

        ),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                child: Text(
                  '저도 너무 궁금합니다!!!!!!!!',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 2),
                child: Text(
                  'ID',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width:320,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 2),
                child: Text(
                  '답글달기',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
