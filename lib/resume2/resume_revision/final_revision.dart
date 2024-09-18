import 'package:flutter/material.dart';

class FinalPage extends StatelessWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const FinalPage({
    Key? key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최종 수정된 자기소개서'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '첫 번째 문단:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(firstParagraph, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 20),

              const Text(
                '두 번째 문단:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(secondParagraph, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 20),

              const Text(
                '세 번째 문단:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(thirdParagraph, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 이전 화면으로 돌아가기
                  },
                  child: const Text('수정 완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}