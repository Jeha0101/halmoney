import 'package:flutter/material.dart';
import '../introduction_service.dart';
import 'third_revision.dart';

class SecondParagraphPage extends StatefulWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const SecondParagraphPage({
    super.key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  });

  @override
  _SecondParagraphPageState createState() => _SecondParagraphPageState();
}

class _SecondParagraphPageState extends State<SecondParagraphPage> {
  final TextEditingController _modificationController = TextEditingController();
  String revisedSecondParagraph = '';
  bool _isLoading = false;
  final IntroductionService _service = IntroductionService();

  @override
  void initState() {
    super.initState();
    revisedSecondParagraph = widget.secondParagraph;
  }

  Future<void> _editSecondParagraph({String tag = ''}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final revisedText = await _service.generateRevisedIntroduction(
       widget.secondParagraph,
        '${_modificationController.text}$tag',
      );
      setState(() {
        revisedSecondParagraph = revisedText;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToThirdPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThirdParagraphPage(
          firstParagraph: widget.firstParagraph,
          secondParagraph: revisedSecondParagraph.isNotEmpty?revisedSecondParagraph:widget.secondParagraph,
          thirdParagraph: widget.thirdParagraph,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('두 번째 문단 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('두 번째 문단을 수정하세요:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            // 수정 이전 문단 표시
            const Text('수정 이전 문단:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.secondParagraph,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 수정 이후 문단 표시
            const Text('수정 이후 문단:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  revisedSecondParagraph.isNotEmpty
                      ? revisedSecondParagraph
                      : '아직 수정된 문단이 없습니다.', // 수정된 문단이 없으면 기본 메시지 출력
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextField는 위에 배치
                  TextField(
                    controller: _modificationController,
                    decoration: const InputDecoration(hintText: '수정 사항을 입력하세요'),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection:Axis.horizontal,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => _editSecondParagraph(tag: '간략하게'),
                            child: const Text('간략하게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editSecondParagraph(tag: '구체적으로'),
                            child: const Text('구체적으로'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editSecondParagraph(tag: '자연스럽게'),
                            child: const Text('자연스럽게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editSecondParagraph(tag: '공손하게'),
                            child: const Text('공손하게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editSecondParagraph(tag: '더 길게'),
                            child: const Text('더 길게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editSecondParagraph(tag: '더 짧게'),
                            child: const Text('더 짧게'),
                          ),
                        ],
                      )
                  )

                  // 태그 버튼 추가
                ],
              ),
            ),

            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _editSecondParagraph,
                  child: const Text('수정하기'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _goToThirdPage,
                  child: const Text('다음 문단 수정'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}