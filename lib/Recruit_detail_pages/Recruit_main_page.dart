import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/AI_main_page.dart';



class Recruit_main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pomodoro Timer APP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Logo box'),
            backgroundColor: Colors.amber,
            toolbarHeight: 35
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget>[
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width:33),
                Text('방이역 인근 수학학원 보조교사 구해요.',
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),)
              ],
            ),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Image.asset(
                    'assets/송파구청.png',
                    height: 170,
                    width: 335,
                    fit: BoxFit.cover,
                  ),
                )

              ],

            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 342,
                  height: 180,
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
                          Text('송파구 방이동 ')
                        ],
                      ),
                      SizedBox(height:20),
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
                          Text('세후 월 200만원')
                        ],
                      ),
                      SizedBox(height:20),
                      Row(
                        children: [
                          SizedBox(width:35),
                          Text('요일',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(width: 25),
                          Row(
                            children: [
                              Container(
                                width:30,
                                height:30,

                                decoration: BoxDecoration(
                                  border:Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    Text('월')
                                  ]
                                )

                              ),
                              SizedBox(width: 5),
                              Container(
                                  width:30,
                                  height:30,

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text('화')
                                      ]
                                  )

                              ),
                              SizedBox(width: 5),
                              Container(
                                  width:30,
                                  height:30,

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text('수')
                                      ]
                                  )

                              ),
                              SizedBox(width: 5),
                              Container(
                                  width:30,
                                  height:30,

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text('목')
                                      ]
                                  )

                              ),
                              SizedBox(width: 5),
                              Container(
                                  width:30,
                                  height:30,

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text('금')
                                      ]
                                  )

                              ),
                              SizedBox(width: 5),
                              Container(
                                  width:30,
                                  height:30,

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text('토')
                                      ]
                                  )

                              ),
                              SizedBox(width: 5),
                              Container(
                                  width:30,
                                  height:30,

                                  decoration: BoxDecoration(
                                    border:Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text('일')
                                      ]
                                  )

                              )
                            ],
                          )


                        ],
                      ),
                      SizedBox(height:20),
                      Row(
                        children: [
                          SizedBox(width:35),
                          Text('날짜',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(width: 25),
                          Text('D-',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:Colors.blueAccent,
                          ),),
                          SizedBox(width:10),
                          Text('300')
                        ],
                      ),

                    ],
                  ),
                )
              ],
            )
          ]
        )
      ),

    );
  }
}