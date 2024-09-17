import 'package:flutter/material.dart';
import 'package:halmoney/resume2/introduction_service.dart';
import 'package:halmoney/resume2/second_revision.dart';


class FirstParagraphPage extends StatefulWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const FirstParagraphPage({
    Key? key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  }) : super(key: key);

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

  Future<void> _editFirstParagraph() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final revisedText = await _service.generateRevisedIntroduction(
        widget.firstParagraph, // 수정 이전 문단 전달
        _modificationController.text, // 수정 내용 전달
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
          firstParagraph: revisedFirstParagraph.isNotEmpty?revisedFirstParagraph:widget.firstParagraph,
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
            const Text('첫 번째 문단을 수정하세요:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),

            // 수정 이전 문단 표시
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
                  revisedFirstParagraph!=widget.firstParagraph
                      ? revisedFirstParagraph
                      : '아직 수정된 문단이 없습니다.',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _modificationController,
              decoration: const InputDecoration(hintText: '수정 사항을 입력하세요'),
            ),

            const SizedBox(height: 10),

            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _editFirstParagraph,
              child: const Text('수정하기'),
            ),

            ElevatedButton(
              onPressed: _goToSecondPage,
              child: const Text('다음 문단 수정'),
            ),
          ],
        ),
      ),
    );
  }
}