import 'package:flutter/material.dart';
import 'package:halmoney/resume2/introduction_service.dart';
import 'package:halmoney/resume2/resume_revision/second_revision.dart';


class FirstParagraphPage extends StatefulWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const FirstParagraphPage({
    super.key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  });

  @override
  _FirstParagraphPageState createState() => _FirstParagraphPageState();
}

class _FirstParagraphPageState extends State<FirstParagraphPage> {
  final TextEditingController _modificationController = TextEditingController();
  String revisedFirstParagraph = ''; // 수정된 문단 저장
  bool _isLoading = false;
  final IntroductionService _service = IntroductionService();

  @override
  void initState() {
    super.initState();
    revisedFirstParagraph = widget.firstParagraph;
  }

  Future<void> _editFirstParagraph({String tag = ''}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 수정 내용에 태그를 추가
      final revisedText = await _service.generateRevisedIntroduction(
        widget.firstParagraph, // 수정 이전 문단 전달
        '${_modificationController.text} $tag', // 수정 내용 + 태그 전달
      );
      setState(() {
        revisedFirstParagraph = revisedText; // 수정된 문단 업데이트
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

  void _goToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondParagraphPage(
          firstParagraph: revisedFirstParagraph.isNotEmpty ? revisedFirstParagraph : widget.firstParagraph,
          secondParagraph: widget.secondParagraph,
          thirdParagraph: widget.thirdParagraph,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('첫 번째 문단 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('수정 이전 문단:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.firstParagraph,
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
                  revisedFirstParagraph != widget.firstParagraph
                      ? revisedFirstParagraph
                      : '아직 수정된 문단이 없습니다.',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // TextField 및 태그 버튼
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
                          onPressed: () => _editFirstParagraph(tag: '간략하게'),
                          child: const Text('간략하게'),
                        ),
                        ElevatedButton(
                          onPressed: () => _editFirstParagraph(tag: '구체적으로'),
                          child: const Text('구체적으로'),
                        ),
                        ElevatedButton(
                          onPressed: () => _editFirstParagraph(tag: '자연스럽게'),
                          child: const Text('자연스럽게'),
                        ),
                        ElevatedButton(
                          onPressed: () => _editFirstParagraph(tag: '공손하게'),
                          child: const Text('공손하게'),
                        ),
                        ElevatedButton(
                          onPressed: () => _editFirstParagraph(tag: '더 길게'),
                          child: const Text('더 길게'),
                        ),
                        ElevatedButton(
                          onPressed: () => _editFirstParagraph(tag: '더 짧게'),
                          child: const Text('더 짧게'),
                        ),
                      ],
                    )
                  )

                  // 태그 버튼 추가
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _editFirstParagraph,
                  child: const Text('수정하기'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _goToSecondPage,
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