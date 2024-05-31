import 'package:flutter/material.dart';
import 'AI_recommendation_widget.dart';

class AI_mainpage extends StatelessWidget {
  const AI_mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo and Boxes',
      debugShowCheckedModeBanner:  false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Logo and Boxes'),
            backgroundColor: Colors.amber,
            toolbarHeight: 35
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height:15),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 342,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // 그림자 색상
                          spreadRadius: 3, // 그림자 확장 반경
                          blurRadius: 5, // 그림자 흐림 반경
                          offset: const Offset(3, 5), // 그림자 위치 (수평, 수직)
                        ),
                      ],
                    ),
                    // 첫번째 박스의 색상 (임의 지정)
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 30,
                              padding: const EdgeInsets.all(5), // 간격을 주기 위한 패딩
                              child: const Text(
                                '이런 조건을 원해요!', // 제목
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child:Container(
                            height: 46,

                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(208, 208, 208, 1.0), // 테두리 색상
                                  width: 1, // 테두리 두께
                                ),
                              ),
                            ),
                            child: Row( // 버튼을 가로로 배열하기 위해 Row 사용
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 정렬
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(55,30),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('송파구',style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(55,30),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('송파구',style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(55,30),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('송파구',style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(55,30),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('송파구',style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child:Container(
                            height: 46,

                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(208, 208, 208, 1.0), // 테두리 색상
                                  width: 1, // 테두리 두께
                                ),
                              ),
                            ),
                            child: Row( // 버튼을 가로로 배열하기 위해 Row 사용
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 정렬
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('관리직',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('건축/건설',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('보조교사',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('사무직',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                              ],
                            ),
                          ),
                        ),
                        //////////임금 체계 설정/////////
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child:Container(
                            height: 46,

                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(208, 208, 208, 1.0), // 테두리 색상
                                  width: 1, // 테두리 두께
                                ),
                              ),
                            ),
                            child: Row( // 버튼을 가로로 배열하기 위해 Row 사용
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 정렬
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('월급',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('주급',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('시간제',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                                ElevatedButton(
                                  onPressed: () {
                                    // 버튼을 눌렀을 때의 동작
                                  },
                                  style:ElevatedButton.styleFrom(
                                      minimumSize: const Size(40,25),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color.fromRGBO(208, 208, 208, 1.0),
                                        width:1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  child: const Text('상관 없음',style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width:20,),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                ]
            ),
            // 첫번째 박스와 두번째 박스 사이 여백
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                        surfaceTintColor: const Color.fromARGB(100, 51, 51, 255),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(100, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),

                    child: const Text('설정하기', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width:34),
                ]
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 342,
                  height: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // 그림자 색상
                          spreadRadius: 3, // 그림자 확장 반경
                          blurRadius: 5, // 그림자 흐림 반경
                          offset: const Offset(3, 5), // 그림자 위치 (수평, 수직)
                        ),
                      ],
                    ),


                  // 두번째 박스의 색상 (임의 지정)
                  child: const SingleChildScrollView(
                    child: Column(
                      children:[
                        SizedBox(height: 10,),
                        AI_recommendation(),
                        SizedBox(height: 10,),
                        AI_recommendation(),
                        SizedBox(height: 10,),
                        AI_recommendation(),
                        SizedBox(height: 10,),
                        AI_recommendation(),
                        SizedBox(height: 10,),
                        AI_recommendation()
                      ]
                    )
                  )
                ),


              ],
            ),
            const SizedBox(height: 10), // 두번째 박스와 버튼 사이 여백
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                  surfaceTintColor: const Color.fromARGB(100, 51, 51, 255),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(300,40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
              ),

              child: const Text('다시 추천 받기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}