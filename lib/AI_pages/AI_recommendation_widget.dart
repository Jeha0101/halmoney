import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AI_recommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
            Container(
                width: 310,
                height: 100,

                decoration: BoxDecoration(
                  color: Colors.white,
                  border:Border.all(
                    color: Color.fromRGBO(208, 208, 208, 1.0),
                    width: 0.5,

                  ),
                  borderRadius: BorderRadius.circular(15),

                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(208, 208, 208, 1.0).withOpacity(0.5), // 그림자 색상
                      spreadRadius: 4, // 그림자 확장 반경
                      blurRadius: 3, // 그림자 흐림 반경
                      offset: Offset(5, 3), // 그림자 위치 (수평, 수직)
                    ),
                  ],
                ),
                child:Row(
                    children:[
                      SizedBox(width:10,),
                      Container(
                        color:Colors.grey,
                        width: 90,
                        height: 90,
                        child:Column(
                          children: [
                            Image.asset(
                              "assets/송파구청.png",
                              width: 90,
                              height: 90,

                            )
                          ],
                        )
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 150,
                        height:80,
                        color: Colors.grey,
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                         children:[
                           Container(
                             child:Row(
                               children: [
                                 Text(
                                     '송파구청 관리인',
                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                 ),
                               ],
                             )
                           ),
                           SizedBox(height:3,),
                           Container(
                               child:Row(
                                 children: [
                                   Text(
                                       '서울 송파구 방이동',
                                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color:Color.fromARGB(250,69,99,255)),
                                   ),
                                 ],
                               )
                           ),

                           SizedBox(height:3,),
                           Container(
                               child:Row(
                                 children: [
                                   Text(
                                     '세후 월 500~550 만원',
                                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color:Colors.black),
                                   ),
                                 ],
                               )
                           ),

                         ]
                        )
                      )
                    ]

                )
            );
  }
}

