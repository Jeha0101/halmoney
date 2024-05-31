import 'package:flutter/material.dart';




class Recruit_main extends StatelessWidget {
  const Recruit_main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer APP',
      home: Scaffold(
          appBar: AppBar(
              title: const Text('Logo box'),
              backgroundColor: Colors.blue,
              toolbarHeight: 35
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                const SizedBox(height:10),
                const Row(
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
                const SizedBox(height:10),
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
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 342,
                      height: 150,
                      decoration: const BoxDecoration(
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
                          const Row(
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
                          const SizedBox(height:10),
                          const Row(
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
                          const SizedBox(height:10),
                          Row(
                            children: [
                              const SizedBox(width:35),
                              const Text('요일',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),),
                              const SizedBox(width: 25),
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
                                      child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text('월')
                                          ]
                                      )

                                  ),
                                  const SizedBox(width: 5),
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
                                      child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text('화')
                                          ]
                                      )

                                  ),
                                  const SizedBox(width: 5),
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
                                      child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text('수')
                                          ]
                                      )

                                  ),
                                  const SizedBox(width: 5),
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
                                      child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text('목')
                                          ]
                                      )

                                  ),
                                  const SizedBox(width: 5),
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
                                      child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text('금')
                                          ]
                                      )

                                  ),
                                  const SizedBox(width: 5),
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
                                      child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text('토')
                                          ]
                                      )

                                  ),
                                  const SizedBox(width: 5),
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
                                      child:const Row(
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
                          const SizedBox(height:10),
                          const Row(
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
                ),
                const SizedBox(height:15),
                Column(
                  children: [
                    const Row(
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
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                            width: 342,
                            height: 180,
                            decoration: const BoxDecoration(
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
                            child:const SingleChildScrollView(
                              child:Column(
                                children: [
                                  Text(
                                    'ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ'
                                        'ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ'
                                        'kkkkkkkkkkklkkkkkkkkkkkkkk'
                                        'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
                                        'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
                                        'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
                                        'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk',

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
                )
              ]
          )
      ),

    );
  }
}