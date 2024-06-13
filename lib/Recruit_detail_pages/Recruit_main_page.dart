
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halmoney/resume2/select_skill_page2.dart';

class Recruit_main extends StatelessWidget {
  final String id;
  final int num;
  final String title;
  final String address;
  final String wage;
  final String career;
  final String detail;
  final String workweek;

  Recruit_main({
    required this.id,
    required this.num,
    required this.title,
    required this.address,
    required this.wage,
    required this.career,
    required this.detail,
    required this.workweek,
    Key? key,
  }): super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(250, 51, 51, 255),
            elevation: 1.0,
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.grey,
                ),
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:33),
                          Expanded(child:
                          Text(title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),))
                        ],
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.asset(
                                'assets/images/songpa.png',
                                height: 175,
                                width: 335,
                                fit: BoxFit.cover,
                              )


                          )

                        ],

                      ),
                      SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 342,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color.fromARGB(250, 51, 51, 255), // 테두리 색상
                                  width: 1,

                                ),
                                bottom: BorderSide(
                                  color: Color.fromARGB(250, 51, 51, 255), // 테두리 색상
                                  width: 1, // 테두리 너비
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width:25),
                                    Text('근무지',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),),
                                    SizedBox(width: 25),
                                    Expanded(child: Text(address,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),),
                                    )
                                  ],
                                ),
                                SizedBox(height:10),
                                Row(
                                  children: [
                                    SizedBox(width:8),

                                    Text('급여방식',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),),
                                    SizedBox(width: 25),
                                    Text(wage)
                                  ],
                                ),
                                SizedBox(height:10),
                                Row(
                                  children: [
                                    SizedBox(width:5),
                                    Text('근무 방식',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),),
                                    SizedBox(width: 25),
                                    Text(workweek),


                                  ],
                                ),
                                SizedBox(height:10),
                                Row(
                                  children: [
                                    SizedBox(width:5),
                                    Text('경력 유무',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),),
                                    SizedBox(width: 25),
                                    Text(career)
                                  ],
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height:15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width:25),
                              Text('상세정보',style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Container(
                                  width: 342,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Color.fromARGB(250, 51, 51, 255), // 테두리 색상
                                        width: 1,

                                      ),
                                      left: BorderSide(
                                        color: Color.fromARGB(250, 51, 51, 255), // 테두리 색상
                                        width: 1, // 테두리 너비
                                      ),
                                    ),
                                  ),
                                  child:SingleChildScrollView(
                                    child:Column(
                                      children: [
                                        Text(
                                          detail,

                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),)
                                      ],
                                    ),
                                  )
                              )
                            ],
                          )

                        ],
                      ),


                    ]
                ),
              ),
              Positioned(
                bottom: 10,
                right: 15,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(250, 51, 51, 255), // 버튼의 배경색을 파란색으로 설정
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectSkillPage(id: id),
                      ),
                    );
                  },
                  child: Text(
                    '지원하기',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )

      ),

    );
  }
}