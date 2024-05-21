import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';
import 'package:halmoney/Community_pages/Community_detail_page.dart';

class Community_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommunityDetail()),
      );
    },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Color.fromARGB(255, 217, 217, 217), // 버튼의 테두리 색상
              width: 1.0, // 버튼의 테두리 두께
            ),
          ),
        ),
        child: Container(
          height: 119,
          width: 420,
          decoration: BoxDecoration(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Text(
                  '행복 요양원 어떤가요?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "성자신손 오백 년은 우리 황실이요 산고수려[2] 동반도는 우리 본국일세애국하는 열심의기 북악같이 높고충군하는 일편단심 동해같이 깊어천만인의 오직 한 맘 나라 사랑하여농공상 귀천없이 직분만 다하세우리나라 우리황제 황천이 도우군민공락 만만세에 태평독립하세무궁화 삼천리 화려강산 조선 사람 조선으로 길이 보존하세"

                  ,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '03.25',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '조회수 10',
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
