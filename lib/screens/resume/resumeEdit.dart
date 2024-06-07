import 'package:flutter/material.dart';

class ResumeEdit extends StatelessWidget {
  final String id;
  const ResumeEdit({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title : const Text('이력서 작성'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left : 30.0, right: 30.0),
            child: ListView(
              children: [
                const SizedBox(height: 30,),
                //개인정보란
                Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color : Colors.grey,
                            spreadRadius:2.5,
                            blurRadius: 10.0,
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 60,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '홍길동',    //사용자 이름 입력
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          '남자/1970년생',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('주소',
                          style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        Text('전화번호',
                          style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('서울시 어쩌구저쩌구', //사용자 주소 입력하기
                          style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        Text('010-1234-5678', // 사용자 전화번호 입력하기
                          style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
