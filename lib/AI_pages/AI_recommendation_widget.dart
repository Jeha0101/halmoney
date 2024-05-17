import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';

class AI_recommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Recruit_main()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Container(
        width: 310,
        height: 100,
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
              width: 90,
              height: 90,
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
            SizedBox(width: 15),
            Container(
              width: 150,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          '송파구청 관리인',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          '서울 송파구 방이동',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color.fromARGB(250, 69, 99, 255)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          '세후 월 500~550 만원',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
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
