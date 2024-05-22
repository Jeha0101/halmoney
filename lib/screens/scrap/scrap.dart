import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halmoney/models/jopOpening.dart';

class MyScrapScreen extends StatelessWidget{
  const MyScrapScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      home : SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title : const Text('찜 목록'),
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
            children: List.generate(
              jopOpenings.length,
              (index) => Container(
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
                child: Column(
                  children: [
                    // id, title, scrap
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jopOpenings[index].id,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              jopOpenings[index].title,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    // address, wage, ongoing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "주소",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Text(
                                  "${jopOpenings[index].address_first} ${jopOpenings[index].address_second} ${jopOpenings[index].address_third} ${jopOpenings[index].address_fourth}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const Text(
                                  "시급",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Text(
                                  "${jopOpenings[index].wage}원",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          //padding: const EdgeInsets.all(5.0),
                          height: 30,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xff1044FC),
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          child:
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "모집중",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    // 모집공고 상세보기
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "모집공고 상세보기",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, size: 30,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
