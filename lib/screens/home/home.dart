import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/AI_recomm_page.dart';
import 'package:halmoney/AI_pages/AI_select_cond_page.dart';
import 'package:halmoney/screens/map/mapPage.dart';
import 'package:halmoney/screens/resume/step1_hello.dart';
import 'package:url_launcher/url_launcher.dart';
import '../resume/select_skill_page.dart';
import 'package:halmoney/PublicJobs_pages/PublicJobsDescribe.main.dart';

class MyHomePage extends StatelessWidget{
  final String id;
  const MyHomePage({super.key, required this.id});

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
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          //backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            title: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      style : TextStyle(
                        fontFamily: 'NanumGothicFamily',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.black,
                        //Color.fromARGB(250, 51, 51, 255),
                      ),)
                ),
              ],
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
                  return GestureDetector(
                    onTap: (){
                      if (itemIndex == 0) {
                        plus50();
                      } else if (itemIndex == 1) {
                        worknet();
                      }
                    },
                    child: Image.asset(
                      mainUrls[itemIndex],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
              ),
              const Divider(),

              //이력서 생성 버튼
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25,),
                      // 위젯 설명 텍스트
                      const Text(
                        '손쉽게 이력서를 생성해보세요!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StepHelloPage(id: id)),
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
                              BoxShadow(
                                color : Colors.grey,
                                spreadRadius:1.0,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'AI 자동 이력서 생성',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              Image(
                                image: AssetImage('assets/images/resume.png'),
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

              //AI 추천 시스템
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25,),
                      // 위젯 설명 텍스트
                      const Text(
                        '  AI 추천 공고를 확인해보세요!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AIRecommPage(id: id)),
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
                              BoxShadow(
                                color : Colors.grey,
                                spreadRadius:1.0,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                                // spreadRadius: 0.5,
                                // blurRadius: 10,
                                // offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'AI 추천 시스템',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              Image(
                                image: AssetImage('assets/images/search.png'),
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

              //맞춤 검색
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      // 위젯 설명 텍스트
                      const Text(
                        ' 원하는 조건을 설정해 검색해보세요!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AISelectCondPage(id: id)),
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
                              BoxShadow(
                                color : Colors.grey,
                                spreadRadius:1.0,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                                // spreadRadius: 0.5,
                                // blurRadius: 10,
                                // offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '맞춤 검색 공고 보기',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
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
                      const SizedBox(height: 20,),
                    ],
                  )
              ),


              //지역 검색 위젯
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25,),
                      // 위젯 설명 텍스트
                      const Text(
                        '  지역 검색을 통해 원하는 일자리를 찾아보세요!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
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
                              BoxShadow(
                                color : Colors.grey,
                                spreadRadius:1.0,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                                // spreadRadius: 0.5,
                                // blurRadius: 10,
                                // offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '지역 검색',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
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
              Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25,),
                      // 위젯 설명 텍스트
                      const Text(
                        '공공 일자리 지원과정을 확인해보세요!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // 위젯 내부
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PublicJobsDescribe(id: id)),
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
                              BoxShadow(
                                color : Colors.grey,
                                spreadRadius:1.0,
                                blurRadius: 10.0,
                                offset: Offset(2,2),
                                blurStyle: BlurStyle.inner,
                                // spreadRadius: 0.5,
                                // blurRadius: 10,
                                // offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '공공 일자리 알리미',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
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
  void plus50() async {
    const url = 'https://50plus.or.kr';
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void worknet() async {
    const url = 'https://www.work.go.kr/senior/main/main.do';
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}