import 'package:flutter/material.dart';
import 'PublicJobsApplyCreate.dart';
import 'PublicJobsDescribe.main.dart';

class PublicJobsApplyPage extends StatefulWidget {
  final String id;
  final String applystep;

  PublicJobsApplyPage({
    required this.id,
    required this.applystep,
    Key? key,
  }) : super(key: key);

  @override
  _PublicJobsApplyPageState createState() => _PublicJobsApplyPageState();
}

class _PublicJobsApplyPageState extends State<PublicJobsApplyPage> {
  late Future<List<String>> _questionsFuture;
  int _currentStep = 0;
  List<bool> _isChecked = [];

  @override
  void initState() {
    super.initState();
    // QuestionGeneratorService를 호출해서 질문을 생성
    _questionsFuture = QuestionGeneratorService().generateQuestionsFromText(
      applystep: widget.applystep,
    );

    // 질문 데이터에 맞춰 체크박스 상태를 초기화
    _questionsFuture.then((questions) {
      setState(() {
        _isChecked = List<bool>.filled(questions.length, false);
      });
    });
  }

  void _onStepContinue(List<String> questions) {
    setState(() {
      if (_currentStep < questions.length - 1) {
        _currentStep++;
      } else {
        // 모든 질문이 완료되면 다음 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PublicJobsDescribe(id: widget.id)),
        );
      }
    });
  }

  void _onStepCancel() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지원 절차 확인하기'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<String>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('채용 절차가 없습니다.'));
          } else {
            final questions = snapshot.data!;
            return Stepper(
              currentStep: _currentStep,
              onStepContinue: () => _onStepContinue(questions),
              onStepCancel: _onStepCancel,
              steps: List.generate(questions.length, (index) {
                return Step(
                  title: Text('절차 ${index + 1}'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        questions[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= index,
                  state: _isChecked.length > index && _isChecked[index]
                      ? StepState.complete
                      : StepState.indexed,
                );
              }),
            );
          }
        },
      ),
    );
  }
}