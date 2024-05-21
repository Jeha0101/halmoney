import 'package:flutter/material.dart';

class SignupPgTwo extends StatelessWidget {
  const SignupPgTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //타이틀
                const Text(
                    '본인의 정보를 입력해주세요.',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600)),

                const SizedBox(height: 30),

                const Text(
                    '성명',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600)),

                const SizedBox(
                  height: 45,
                  child : TextField(
                    style: TextStyle(fontSize: 15.0, height: 2.0),
                    decoration: InputDecoration(
                        labelText: '이름을 입력하세요'
                    ),
                  ),
                ) ,

                const SizedBox(height:35),

                const Text(
                    '아이디',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600)),

                const SizedBox(
                  height: 45,
                  child : TextField(
                    style: TextStyle(fontSize: 15.0, height: 2.0),
                    decoration: InputDecoration(
                        labelText: '아이디를 입력하세요'
                    ),
                  ),
                ) ,

                const SizedBox(height:35),

                const Text(
                    '비밀번호',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600)),

                const SizedBox(
                  height: 45,
                  child : TextField(
                    style: TextStyle(fontSize: 15.0, height: 2.0),
                    decoration: InputDecoration(
                        labelText: '비밀번호를 입력하세요'
                    ),
                  ),
                ) ,

                const SizedBox(height:35),

                const Text(
                    '비밀번호 확인',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600)),

                const SizedBox(
                  height: 45,
                  child : TextField(
                    style: TextStyle(fontSize: 15.0, height: 2.0),
                    decoration: InputDecoration(
                        labelText: '비밀번호를 한 번 더 입력하세요'
                    ),
                  ),
                ) ,

                const SizedBox(height:35),

                const Text(
                    '전화번호',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600)),

                const SizedBox(
                  height: 45,
                  child : TextField(
                    style: TextStyle(fontSize: 15.0, height: 2.0),
                    decoration: InputDecoration(
                        labelText: '전화번호를 입력하세요'
                    ),
                  ),
                ),

                const SizedBox(height:20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: _buttonActive ? const Color.fromARGB(250, 51, 51, 255) : Colors.grey,
                        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                        minimumSize: const Size(360,45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                    onPressed: () {},
                    child: const Text('가입완료',style: TextStyle(color: Colors.white),),
                  ),
              ],
            )
        )
    );
  }
}

