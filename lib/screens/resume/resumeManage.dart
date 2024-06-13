import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/select_skill_page.dart';

class ResumeManage extends StatelessWidget{
  final String id;

  const ResumeManage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NanumGothicBold',
      ),

      home : SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title : const Text('이력서 관리'),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded,),
              color: Colors.grey,
            ),
          ),
          body: ListView(
            children: [
              Divider(),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectSkillPage(id: id)),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(18.0),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(250, 51, 51, 255),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('새 이력서 작성하기',
                        style : TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        )
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(18.0),
                height: 205,
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
                child: Column()
              ),
            ]
          ),
        ),
      ),
    );
  }
}
