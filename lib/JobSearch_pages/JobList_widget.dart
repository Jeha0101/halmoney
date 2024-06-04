import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/Recruit_detail_pages/Recruit_main_page.dart';

class JobList extends StatelessWidget {
  final String title;
  final String address;
  final String wage;
  final String career;
  final String detail;
  final String workweek;

  const JobList({
    required this.title,
    required this.address,
    required this.wage,
    required this.career,
    required this.detail,
    required this.workweek,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Recruit_main(
                title: title,
                address: address,
                wage: wage,
                career: career,
                detail: detail,
                workweek: workweek

            )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 370,
              height: 100,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/songpa.png",
                          width: 90,
                          height: 90,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 200,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 3),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child:  Text(
                                  address,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color.fromARGB(250, 69, 99, 255)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                wage,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )

    );
  }
}
