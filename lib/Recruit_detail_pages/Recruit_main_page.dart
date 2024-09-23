
import 'package:flutter/material.dart';
import 'package:halmoney/resume2/resumeManage2.dart';

class Recruit_main extends StatelessWidget {
  final String id;
  final int num;
  final String title;
  final String address;
  final String wage;
  final String career;
  final String detail;
  final String workweek;
  final String image_path;
  final String endday;

  const Recruit_main({
    required this.id,
    required this.num,
    required this.title,
    required this.address,
    required this.wage,
    required this.career,
    required this.detail,
    required this.workweek,
    required this.image_path,
    required this.endday,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    //wage split하기
    List<String> wageParts = wage.split('/');
    String payment = wageParts[0].trim();
    String amount = wageParts.length > 1 ? wageParts[1].trim(): '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5.0,
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.grey,
                ),
                Image.asset(
                  'assets/images/img_logo.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    '채용정보',
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding : const EdgeInsets.only(left:30.0, right: 25.0, top: 30.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child:
                            Text(title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),))
                          ],
                        ),
                        const SizedBox(height:20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  image_path,
                                  height: 185,
                                  width: 350,
                                  fit: BoxFit.cover,
                                )
                            )
                          ],
                        ),
                        const SizedBox(height: 20),

                        GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2, //세로에 들어가는 박스 수
                            crossAxisSpacing: 10, //박스 간 가로 거리
                            childAspectRatio: 2, //높이설정
                            children: [
                              _buildInfoBox('급여', wage),
                              _buildInfoBox('요일', workweek),
                            ]
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1, height: 1, color: Colors.grey,),
                        const SizedBox(height: 20),

                        const Text(
                          '근무지역',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          address,

                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        const SizedBox(height: 40),
                        const Divider(thickness: 1, height: 1, color: Colors.grey,),
                        const SizedBox(height: 20),

                        const Text(
                          '근무조건',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            const Text(
                              '급여',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(width: 52),

                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(250, 51, 51, 255), width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white60,
                              ),
                              child: Text(
                                payment,
                                style: const TextStyle(
                                  color: Color.fromARGB(250, 51, 51, 255),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              amount,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            const Text(
                              '근무요일',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(width: 25),

                            Text(
                              workweek,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            const Text(
                              '경력유무',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),

                            ),

                            const SizedBox(width: 25),

                            SizedBox(
                              width : 270,
                              child : Text(
                                overflow: TextOverflow.ellipsis,
                                career,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 40),
                        const Divider(thickness: 1, height: 1, color: Colors.grey,),
                        const SizedBox(height: 20),

                        const Text(
                          '상세요강',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          detail,
                          style: const TextStyle(
                              height: 1.8,
                              fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Divider(thickness: 1, height: 1, color: Colors.grey,),
                        const SizedBox(height: 20),

                        const Text(
                          '마감일',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          endday,
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 20,
                            color: Colors.blueAccent,
                          ),
                        ),


                        const SizedBox(height: 100),

                      ]
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 15,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(250, 51, 51, 255), // 버튼의 배경색을 파란색으로 설정
                    padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumeManage2(id: id, num:num, title:title),
                      ),
                    );


                  },
                  child: const Text(
                    '지원하기',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )

      ),

    );
  }
}

Widget _buildInfoBox(String title, String value) {
  return SizedBox(
    height: 80,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white60,
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(250, 65, 51, 255),
            ),
          ),
        ],
      ),
    ),
  );
}
