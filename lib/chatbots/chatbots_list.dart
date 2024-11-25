import 'package:flutter/material.dart';

class ChatbotsList extends StatefulWidget {
  final userInfo;

  const ChatbotsList({super.key, required this.userInfo});

  @override
  _ChatbotsListState createState() => _ChatbotsListState();
}

class _ChatbotsListState extends State<ChatbotsList> {
  @override
  Widget build(BuildContext context) {
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
                  '채팅',
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
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 25.0, top: 30.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            '챗봇 목록',
                            style: TextStyle(
                              fontFamily: 'NanumGothicFamily',
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ))),
            Positioned(
              bottom: 0,
              right: 15,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 100, 100, 255),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        '새로운 채팅 시작하기',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
