import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/screens/home/home.dart';
import 'package:halmoney/screens/scrap/scrap.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key,});

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
            title : const Text('마이페이지'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: [
              Divider(),
              SizedBox(height: 30,),
              //개인정보란
              Row(
                children: [
                  SizedBox(width: 40,),
                  Container(
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
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
                    child: Icon(
                      Icons.person_outline,
                      size: 60,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    '홍길동',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  ),
                ],
              ),
              SizedBox(height: 30,),
              //마이페이지 메뉴
              GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                  childAspectRatio: 4/3 ,
                children: <Widget>[
                  //이력서 관리
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScrapScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left:20),
                      padding: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                          top: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.edit_note,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          const Text(
                            '이력서 관리',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //지원현황
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScrapScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right:20),
                      padding: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                          top: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.recent_actors_outlined,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          const Text(
                            '지원현황',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //찜 목록
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScrapScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left:20),
                      padding: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite_border_rounded,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          const Text(
                            '찜 목록',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //최근 본 공고
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScrapScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right:20),
                      padding: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          const Text(
                            '최근 본 공고',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //내가 쓴 글
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScrapScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left:20),
                      padding: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.list_alt,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          const Text(
                            '내가 쓴 글',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //내가 작성한 댓글
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyScrapScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right:20),
                      padding: const EdgeInsets.all(20),
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.insert_comment_outlined,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          const Text(
                            '내가 작성한 댓글',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
