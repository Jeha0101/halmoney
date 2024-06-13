import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/resumeManage.dart';
import 'package:halmoney/screens/scrap/scrap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageScreen extends StatefulWidget {
  final String id;

  //final bool isLoggedIn;
  const MyPageScreen({super.key, required this.id});

  @override
  _MyPageScreen createState() => _MyPageScreen();
}

class _MyPageScreen extends State<MyPageScreen>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name ='';

  @override
  void initState(){
    super.initState();
    _fetchResumeData();
  }

  Future<void> _fetchResumeData() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        final DocumentSnapshot ds =
        await _firestore.collection('user').doc(docId).get();

        final data = ds.data() as Map<String, dynamic>;

        // Fetching user information
        name = data['name'];
      }
    } catch (error) {
      print("Failed to fetch resume data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch resume data: $error")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'NanumGothicBold'
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
              const Divider(),
              const SizedBox(height: 50,),
              //개인정보란
              Row(
                children: [
                  //const SizedBox(width: 50,),
                  /*Container(
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
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
                    child: const Icon(
                      Icons.person_outline,
                      size: 60,
                    ),
                  ),*/
                  const SizedBox(width: 30,),
                  Text(
                    '$name님 안녕하세요',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  /*const Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  ),*/
                ],
              ),
              const SizedBox(height: 60,),
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
                        MaterialPageRoute(builder: (context) => ResumeManage(id: widget.id))
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
                          Icon(
                            Icons.edit_note,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          Text(
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
                        MaterialPageRoute(builder: (context) => const MyScrapScreen()),
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
                          Icon(
                            Icons.recent_actors_outlined,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          Text(
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
                        MaterialPageRoute(builder: (context) => const MyScrapScreen()),
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
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          Text(
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
                        MaterialPageRoute(builder: (context) => const MyScrapScreen()),
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
                          Icon(
                            Icons.access_time,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          Text(
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
                        MaterialPageRoute(builder: (context) => const MyScrapScreen()),
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
                          Icon(
                            Icons.list_alt,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          Text(
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
                        MaterialPageRoute(builder: (context) => const MyScrapScreen()),
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
                          Icon(
                            Icons.insert_comment_outlined,
                            size: 50,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            '내가 작성한 댓글',
                            style: TextStyle(
                              fontSize: 18,
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
