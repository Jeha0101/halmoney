import 'package:flutter/material.dart';

class FinalPage extends StatelessWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const FinalPage({
    super.key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  });

  /*void _goToResumeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeView2(
          id: widget.id, // 필요한 다른 정보들
          resumeId: widget.resumeId,
          num: widget.num,
          // 여기서 전달할 문단 추가
          firstParagraph: revisedFirstParagraph,
          secondParagraph: revisedSecondParagraph,
          thirdParagraph: revisedThirdParagraph,
        ),
      ),
    );
  } */

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
                  child: const Text('이력서 생성'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}