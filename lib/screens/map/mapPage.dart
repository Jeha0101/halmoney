import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _State();
}

class _State extends State<MapScreen>{
  //상태변경 함수 정의하기
  void _counter(){

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      home : SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title : const Text('지역 검색'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body:
            ListView(
              children: [
                Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child:
                        Text("채용 공고를 검색할 지역을 선택하세요",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("시/도",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        Text("구/시",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        Text("동/구",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          //padding: const EdgeInsets.all(5.0),
                          height: 30,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          child:
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "다시선택",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          //padding: const EdgeInsets.all(5.0),
                          height: 30,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xff1044FC),
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          child:
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "검색하기",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,

                        child: Container(
                          width: 40,
                          child: Column(
                            children: [
                              Text("서울시",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text('경기도',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,

                        child: Container(
                          width: 40,
                          child: Column(
                            children: [
                              Text("강동구",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text("광진구",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),flex: 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,

                        child: Container(
                          width: 40,
                          child: Column(
                            children: [
                              Text("서울시",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text("서울시",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),flex: 1,
                    ),
                  ]
                ),
              ],
            ),
        ),
      ),
    );
  }
}
