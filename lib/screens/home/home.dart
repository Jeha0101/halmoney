import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/screens/map/mapPage.dart';
import 'package:halmoney/screens/myPage/myPage.dart';
import 'package:halmoney/AI_pages/AI_main_page.dart';
import 'package:halmoney/screens/myPage/myPage.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> mainUrls = [
      "assets/images/50plus.png",
      "assets/images/worknet.png",
    ];
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
            title : Text('할MONEY'),
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: [
              Divider(),
              //광고 이미지 위젯
              CarouselSlider.builder(
                itemCount: mainUrls.length,
                options: CarouselOptions(
                  viewportFraction: 1.0,
                ),
                itemBuilder: (context, itemIndex, realIndex){
                  return Image.asset(
                    "${mainUrls[itemIndex]}",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  );
                },
              ),
              Divider(),
              //AI 추천 공고 위젯
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      // 위젯 설명 텍스트
                      const Text(
                        '  AI추천 서비스를 이용해보세요!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AI_mainpage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(color : Colors.grey,
                                spreadRadius:2.5,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'AI추천 공고 보기',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const Image(
                                image: AssetImage('assets/images/ai.png'),
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              //지역?지도 검색 위젯
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25,),
                      // 위젯 설명 텍스트
                      const Text(
                        '  지역 검색을 통해 원하는 일자리를 찾아보세요!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(color : Colors.grey,
                                spreadRadius:2.5,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '지역 검색',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const Image(
                                image: AssetImage('assets/images/location.png'),
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}