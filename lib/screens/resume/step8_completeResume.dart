// 작성자 : 황제하
// 생성일 : 2024-09-23
// 자기소개서 작성 완료 페이지

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halmoney/get_user_info/user_Info.dart';

class StepCompleteResume extends StatefulWidget {
  final UserInfo userInfo;
  final String userSelfIntroduction;

  StepCompleteResume({
    super.key,
    required this.userInfo,
    required this.userSelfIntroduction,
  });

  @override
  State<StepCompleteResume> createState() => _StepCompleteResumeState();
}

class _StepCompleteResumeState extends State<StepCompleteResume> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(children: [
              // 페이지 이동 영역
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 이전 페이지로 이동
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                        Text('이전',
                            style: TextStyle(
                              fontFamily: 'NanumGothicFamily',
                              fontSize: 20.0,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),

                  //홈 페이지로 이동
                  GestureDetector(
                    onTap: () {
                      for (int i = 0; i < 7; i++) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 30,
                        ),
                        Text('홈으로',
                            style: TextStyle(
                              fontFamily: 'NanumGothicFamily',
                              fontSize: 20.0,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/complete.png'),
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '자기소개서 저장 완료',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: const Text(
                      '아래 버튼을 눌러서 자기소개서를 복사하거나 이력서를 만들어보세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.userSelfIntroduction));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('복사 완료'),
                            content: const Text(
                                '자기소개서가 클립보드에 복사되었습니다. 원하는 곳에 붙여넣으세요.',
                                style: TextStyle(fontSize: 20)
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // 확인 버튼을 누르면 창이 닫힘
                                },
                                child: const Text('확인', style: TextStyle(fontSize: 25)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("자기소개서 복사",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //이력서 생성 페이지로 이동
                    },
                    child: const Text("이력서 만들기",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //이력서 생성 페이지로 연결
                    },
                    child: const Text("자기소개서 보러가기",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              Text(widget.userInfo.userName + '님을 위한 추천 공고',
                  style: TextStyle(
                    fontFamily: 'NanumGothicFamily',
                    fontSize: 20.0,
                    color: Colors.black,
                  )),


              //추천 이력서 리스트 보여주기
            ])),
      ),
    );
  }
}
