import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/AI_recomm_page.dart';
import 'package:halmoney/AI_pages/AI_select_cond_page.dart';
import 'package:halmoney/pages/search_engine.dart';
import 'package:halmoney/screens/map/mapPage.dart';
import 'package:halmoney/screens/resume/step1_hello.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:halmoney/PublicJobs_pages/PublicJobsDescribe.main.dart';
import 'package:halmoney/get_user_info/user_Info.dart';
import 'package:halmoney/PublicJobs_pages/PublicJobsData.dart';
import 'dart:core';

import '../../PublicJobs_pages/PublicJobsDetail.main.dart';

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
    print('update publicjobs list: $publicJobs');
  }


  @override
  Widget build(BuildContext context) {
    List<String> mainUrls = [
      "assets/images/50plus.png",
      "assets/images/worknet.png",
    ];
    userInfo.printUserInfo();
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
                                fontSize: 17,
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

            // AI 추천 시스템
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 25, bottom: 50),
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
            Container(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 20, bottom:20),
              color: Color.fromARGB(80, 211, 211, 211),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '공공 일자리',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> PublicJobsDescribe(id: widget.id))
                          );
                        },
                        child: Text('전체보기', style: TextStyle(color:Colors.black, fontSize: 17),),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                      height: 290,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: publicJobs.length,
                          itemBuilder:(context, index){
                            final job = publicJobs[index];

                            Timestamp? endTimestamp = job['endday'] as Timestamp?;
                            String formattedEndDate = endTimestamp != null
                                ? DateFormat('yyyy-MM-dd').format(endTimestamp.toDate())
                                : '상시모집';

                            return Padding(
                                padding: const EdgeInsets.only(right:16.0),
                                child: JobCard(
                                  image : job['image_path'] ?? 'assets/images/img_logo.png',
                                  title : job['title'] ?? '할MONEY',
                                  description: job['company'] ?? '할MONEY',
                                  region : job['region'] ?? '미정',
                                  endday: formattedEndDate,
                                  id : widget.id,
                                  url: job['url'] ?? '없음',
                                  person: job['person'] ?? '미정',
                                  person2: job['person2'] ?? '미정',
                                  personcareer: job['personcareer'] ?? '미정',
                                  personedu: job['personedu'] ?? '미정',
                                  applystep: job['applystep'] ?? '미정',

                                )
                            );
                          }
                      )
                  )
                ],
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
                          ),
                          SizedBox(width:5),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AISelectCondPage(id: userInfo.userId)),
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
                                      '버튼으로 검색',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            MaterialPageRoute(builder: (context) => PublicJobsDescribe(id: userInfo.userId)),
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