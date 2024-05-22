import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.red,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: (EdgeInsets.only(top: 100)),),
            const Center(
              child: Image(
                image: AssetImage('assets/images/img_logo.png'),
                width: 100,
                height: 120,
              ),
            ),
            Form(child: Container(
              padding: const EdgeInsets.only(left: 60.0, right: 60.0, top:30.0),
              child: Column(
                children: [
                  const Text(
                      "로그인",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'NanumGothicExtraBold',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '아이디'
                      // hintText : '아이디',
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide : BorderSide(
                      //     color: Colors.black38,
                      //     width: 1.0,
                      //   )
                      // )
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '비밀번호'
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                  ),

                  const SizedBox( //위젯 사이에 간격두기
                    height: 20.0,
                  ),
                  ElevatedButton( //로그인 버튼
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                      surfaceTintColor: const Color.fromARGB(100, 51, 51, 255),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(300,45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                    ),
                    onPressed: (){},
                    child: const Text(
                      "로그인",
                    )
                  ),

                  TextButton(onPressed: (){},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(250, 51,51, 51),
                      padding: const EdgeInsets.only(left: 220),
                      textStyle: const TextStyle(fontSize: 13),
                    ), //회원가입 버튼
                    child: const Text("회원가입", textAlign: TextAlign.right),
                  ),

                  const SizedBox( //위젯 사이에 간격두기
                    height: 5.0,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox( //위젯 사이에 간격두기
                    height: 15.0,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black26,
                    ),
                  ),
                  const SizedBox( //위젯 사이에 간격두기
                    height: 15.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: (){},
                    icon: const Icon(Icons.chat_bubble),
                    label: const Text('  카카오톡으로 로그인',),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(250, 255, 230, 0),
                        surfaceTintColor: const Color.fromARGB(100, 255, 230, 0),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(300,45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                    ),
                ],
              ),
            ))
          ],
        ),
      )
    );
  }
}
