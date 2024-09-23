import 'package:flutter/material.dart';
import '../introduction_service.dart';
import 'final_revision.dart'; // 마무리 페이지로 이동

class ThirdParagraphPage extends StatefulWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const ThirdParagraphPage({
    super.key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  });

  @override
  _ThirdParagraphPageState createState() => _ThirdParagraphPageState();
}

class _ThirdParagraphPageState extends State<ThirdParagraphPage> {
  final TextEditingController _modificationController = TextEditingController();
  String revisedThirdParagraph = '';
  bool _isLoading = false;
  final IntroductionService _service = IntroductionService();

  @override
  void initState() {
    super.initState();
    revisedThirdParagraph = widget.thirdParagraph;
  }

  Future<void> _editThirdParagraph({String tag = ''}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final revisedText = await _service.generateRevisedIntroduction(
        revisedThirdParagraph,
        '${_modificationController.text} $tag',
      );
      setState(() {
        revisedThirdParagraph = revisedText;
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

  void _goToFinalPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalPage(
          firstParagraph: widget.firstParagraph,
          secondParagraph: widget.secondParagraph,
          thirdParagraph: revisedThirdParagraph.isNotEmpty
              ? revisedThirdParagraph
              : widget.thirdParagraph,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('세 번째 문단 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('세 번째 문단을 수정하세요:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            const Text('수정 이전 문단:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.thirdParagraph,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('수정 이후 문단:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  revisedThirdParagraph != widget.thirdParagraph
                      ? revisedThirdParagraph
                      : '아직 수정된 문단이 없습니다.',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height:10),
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
                            onPressed: () => _editThirdParagraph(tag: '간략하게'),
                            child: const Text('간략하게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editThirdParagraph(tag: '구체적으로'),
                            child: const Text('구체적으로'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editThirdParagraph(tag: '자연스럽게'),
                            child: const Text('자연스럽게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editThirdParagraph(tag: '공손하게'),
                            child: const Text('공손하게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editThirdParagraph(tag: '더 길게'),
                            child: const Text('더 길게'),
                          ),
                          ElevatedButton(
                            onPressed: () => _editThirdParagraph(tag: '더 짧게'),
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
                  onPressed: _editThirdParagraph,
                  child: const Text('수정하기'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _goToFinalPage,
                  child: const Text('수정 완료'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}