import 'package:flutter/material.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';

class AI_recommendation extends StatelessWidget {
  const AI_recommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Recruit_main()),
        );*/
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: SizedBox(
        width: 310,
        height: 100,
        child: Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(
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
            const SizedBox(width: 15),
            SizedBox(
              width: 150,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: const Row(
                      children: [
                        Text(
                          '송파구청 관리인',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    child: const Row(
                      children: [
                        Text(
                          '서울 송파구 방이동',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color.fromARGB(250, 69, 99, 255)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    child: const Row(
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
