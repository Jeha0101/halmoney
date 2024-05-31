import 'package:flutter/material.dart';

class Community_comment extends StatelessWidget {
  const Community_comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: 420,
      decoration: const BoxDecoration(
     
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(500, 217, 217, 217), // 라인 색상
            width: 1.0,
            // 라인 두께
          ),

        ),
      ),
      child:const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                child: Text(
                  '저도 너무 궁금합니다!!!!!!!!',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 2),
                child: Text(
                  'ID',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width:320,),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 2),
                child: Text(
                  '답글달기',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
