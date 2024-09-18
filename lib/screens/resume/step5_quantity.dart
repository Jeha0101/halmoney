import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/userInput.dart';
import 'package:halmoney/screens/resume/step6_inputEdit.dart';

class StepQuantityPage extends StatefulWidget {
  final UserInput userInput;

  StepQuantityPage({
    super.key,
    required this.userInput,
  });

  @override
  State<StepQuantityPage> createState() => _StepQuantityPageState();
}

class _StepQuantityPageState extends State<StepQuantityPage> {
  int quantity = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/img_logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  '할MONEY',
                  style: TextStyle(
                    fontFamily: 'NanumGothicFamily',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 25.0, bottom: 15.0),
        child: Column(
          children: [
            // 페이지 이동 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 이전 페이지로 이동
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                      Text('이전',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),

                //다음 페이지로 이동
                GestureDetector(
                  onTap: () {
                    widget.userInput.editQuantity(quantity);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StepInputEditPage(
                              userInput : widget.userInput
                          )),
                    );
                  },
                  child: const Row(
                    children: [
                      Text('다음',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                      Icon(
                        Icons.chevron_right,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('자기소개서의\n분량을 선택해주세요',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontWeight: FontWeight.w500,
                            fontSize: 28.0,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  const SizedBox(height: 70),

                  //분량 선택
                  DropdownButton<int>(
                    value: quantity, // 현재 선택된 값
                    items: List.generate(19, (index) {
                      int value = 100 + index * 50; // 100자부터 50단위로 1000자까지 생성
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value자',
                            style: const TextStyle(
                              fontFamily: 'NanumGothicFamily',
                              fontWeight: FontWeight.w500,
                              fontSize: 28.0,
                              color: Colors.black,
                            ),
                        ), // 드롭다운 메뉴에 표시할 텍스트
                      );
                    }),
                    onChanged: (newValue) {
                      setState(() {
                        quantity = newValue ?? 100; // 선택된 값을 int로 저장
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}