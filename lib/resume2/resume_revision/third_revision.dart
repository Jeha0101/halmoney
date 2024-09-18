import 'package:flutter/material.dart';
import '../introduction_service.dart';
import 'final_revision.dart'; // 마무리 페이지로 이동

class ThirdParagraphPage extends StatefulWidget {
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const ThirdParagraphPage({
    Key? key,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  }) : super(key: key);

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

  Future<void> _editThirdParagraph() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final revisedText = await _service.generateRevisedIntroduction(
        revisedThirdParagraph,
        _modificationController.text,
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
            TextField(
              controller: _modificationController,
              decoration: const InputDecoration(hintText: '수정 사항을 입력하세요'),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _editThirdParagraph,
              child: const Text('수정하기'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _goToFinalPage,
              child: const Text('마무리하기'),
            ),
          ],
        ),
      ),
    );
  }
}