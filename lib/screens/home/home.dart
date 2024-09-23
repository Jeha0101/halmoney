import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/AI_recomm_page.dart';
import 'package:halmoney/AI_pages/AI_select_cond_page.dart';
import 'package:halmoney/pages/search_engine.dart';
import 'package:halmoney/screens/map/mapPage.dart';
import 'package:halmoney/screens/resume/step1_hello.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:halmoney/PublicJobs_pages/PublicJobsDescribe.main.dart';
import 'package:halmoney/get_user_info/user_Info.dart';
import 'package:halmoney/PublicJobs_pages/PublicJobsData.dart';
import 'dart:core';

class MyHomePage extends StatefulWidget {
  final String id;

  const MyHomePage({super.key, required this.id});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserInfo? userInfo;
  PublicJobsData publicJobsData = PublicJobsData();
  List<Map<String, dynamic>> publicJobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _fetchJobs();
  }

  //사용자 정보 불러오기
  Future<void> _fetchUserInfo() async {
    UserInfo fetchedUserInfo = UserInfo(widget.id);
    setState(() {
      userInfo = fetchedUserInfo;
    });
  }

  //공공일자리 데이터 불러오기
  Future<void> _fetchJobs() async {
    List<Map<String, dynamic>> fetchedJobs = await publicJobsData.fetchPublicJobs();
    setState(() {
      publicJobs = fetchedJobs;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<String> mainUrls = [
      "assets/images/homeimages/public_work_page.png",
      "assets/images/homeimages/recommendation_page.png",
      "assets/images/homeimages/resume_create_page.png",
      "assets/images/homeimages/search_engine_page.png",
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NanumGothicBold',
      ),
      home: SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            title: Row(
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
                    style: TextStyle(
                      fontFamily: 'NanumGothicFamily',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(children: [
            // 광고 이미지 위젯
            CarouselSlider.builder(
              itemCount: mainUrls.length,
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 3000), // 애니메이션 시간
                autoPlayCurve: Curves.fastOutSlowIn, // 슬라이드 애니메이션 곡선
              ),
              itemBuilder: (context, itemIndex, realIndex) {
                return GestureDetector(
                  onTap: () {
                    String imageUrl = mainUrls[itemIndex];
                    if ( imageUrl== "assets/images/homeimages/resume_create_page.png") {
                      UserInfo userInfo = UserInfo(widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StepHelloPage(userInfo: userInfo)),
                      );
                    } else if (imageUrl =="assets/images/homeimages/recommendation_page.png") {
                      UserInfo userInfo = UserInfo(widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AIRecommPage(id: widget.id)),
                      );
                    } else if (imageUrl == "assets/images/homeimages/search_engine_page.png") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchEngine()),
                      );
                    } else if (imageUrl == "assets/images/homeimages/public_work_page.png") {
                      UserInfo userInfo = UserInfo(widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StepHelloPage(userInfo: userInfo)),
                      );
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

            // 검색 기능
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchEngine()),
                );
              },
              child: Container(
                transform: Matrix4.translationValues(0, -10, 0),
                width: 360,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0.7,
                      blurRadius: 8.0,
                      offset: Offset(0, -2),
                      blurStyle: BlurStyle.inner,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 360,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                        color: const Color.fromARGB(250, 51, 51, 255),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              '원하는 일자리를 검색해보세요!',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0), // Adjust the padding as needed
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: Color.fromARGB(250, 51, 51, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 이력서 생성 버튼
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              height: 330,
              color: const Color.fromARGB(50, 173, 216, 230),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '이력서를 어떻게 작성할지 모르겠다면?\n'
                        '자동으로 이력서를 만들어드려요!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      UserInfo userInfo = UserInfo(widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StepHelloPage(userInfo: userInfo)),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 190,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/resume.png'),
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 30),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AI가 만들어주는 이력서',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black54),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '내가 원하는 일자리와 관련있는\n'
                                      '역량과 경험을 쉽게 작성해보아요',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 230,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(
                                      color: const Color.fromARGB(250, 51, 51, 255),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '이력서 작성하기',
                                      style: TextStyle(
                                          color: Color.fromARGB(250, 51, 51, 255),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            // AI 추천 시스템
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    userInfo != null && userInfo!.userName.isNotEmpty
                        ? '${userInfo?.getUserName()}님에게 딱맞는 일자리'
                        : '사용자 정보를 불러오는 중...',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AIRecommPage(id: widget.id)),
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
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 10.0,
                            offset: Offset(2, 2),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '딱맞는 일자리',
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            //공공일자리
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '공공 일자리',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PublicJobsDescribe(id: widget.id)),
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
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 10.0,
                            offset: Offset(2, 2),
                            blurStyle: BlurStyle.inner,
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
                  const SizedBox(height: 20),
                ],
              ),
            ),


            // 맞춤 검색
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '원하는 조건 고르기',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AISelectCondPage(id: widget.id)),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/images/check.png'),
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 30),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height:20),
                                    const Text(
                                      '나는 이런 일을 원해요!\n'
                                          '조건을 정해 일자리를 알아보아요',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 230,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0),
                                        border: Border.all(
                                          color: const Color.fromARGB(250, 51, 51, 255),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '조건 검색하기',
                                          style: TextStyle(
                                              color: Color.fromARGB(250, 51, 51, 255),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            // 지역 검색 위젯
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '원하는 지역 고르기',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapScreen()),
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
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 10.0,
                            offset: Offset(2, 2),
                            blurStyle: BlurStyle.inner,
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
                  const SizedBox(height: 20),
                ],
              ),
            ),


          ]),
        ),
      ),
    );
  }
}
