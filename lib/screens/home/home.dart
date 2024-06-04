import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/screens/map/mapPage.dart';
import 'package:halmoney/AI_pages/AI_main_page.dart';

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
          fontFamily: 'NanumGothicBold',
      ),
      home : SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/img_logo.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('할MONEY',
                    style : TextStyle(
                    fontFamily: 'NotoSansKR-Variable',
                    //fontWeight: FontWeight.w600,
                    fontSize: 23.0,
                    color: Colors.black,
                    )
                  ),
                )
              ]
            ),
          ),
          body: ListView(
            children: [
              const Divider(),
              //광고 이미지 위젯
              CarouselSlider.builder(
                itemCount: mainUrls.length,
                options: CarouselOptions(
                  viewportFraction: 1.0,
                ),
                itemBuilder: (context, itemIndex, realIndex){
                  return Image.asset(
                    mainUrls[itemIndex],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  );
                },
              ),
              const Divider(),
              //AI 추천 공고 위젯
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      // 위젯 설명 텍스트
                      const Text(
                        '  AI추천 서비스를 이용해보세요!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AI_mainpage()),
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
                              Text(
                                'AI추천 공고 보기',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Image(
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
                      const SizedBox(height: 25,),
                      // 위젯 설명 텍스트
                      const Text(
                        '  지역 검색을 통해 원하는 일자리를 찾아보세요!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MapScreen()),
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
                              Text(
                                '지역 검색',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Image(
                                image: AssetImage('assets/images/location.png'),
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
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