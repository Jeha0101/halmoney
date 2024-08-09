import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

// 페이지 위젯
class SelfIntroductionRevisionPage extends StatefulWidget {
  final String existingIntroduction;

  const SelfIntroductionRevisionPage({
    Key? key,
    required this.existingIntroduction,
  }) : super(key: key);

  @override
  _SelfIntroductionRevisionPageState createState() =>
      _SelfIntroductionRevisionPageState();
}

class _SelfIntroductionRevisionPageState
    extends State<SelfIntroductionRevisionPage> {
  final TextEditingController _modificationController =
  TextEditingController();
  String revisedIntroduction = '';
  bool _isLoading = false;

  // GPT-3를 사용하여 수정된 자기소개서를 생성하는 함수
  Future<void> _generateRevisedIntroduction() async {
    final apiKey = dotenv.get('GPT_API_KEY');
    const endpoint = 'https://api.openai.com/v1/chat/completions';

    String prompt = '''다음 자기소개서를 바탕으로 아래 수정사항을 적용하여 새로운 자기소개서를 작성:
    기존 자기소개서: ${widget.existingIntroduction}
    수정사항: ${_modificationController.text}
    주의: 인사말과 마무리 인사를 생략하고 수정사항을 명확히 반영한다.''';

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': prompt},
          ],
          'max_tokens': 500,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));

        if (responseBody.containsKey('choices') &&
            responseBody['choices'] is List &&
            responseBody['choices'].isNotEmpty) {
          final text = responseBody['choices'][0]['message']['content'];
          setState(() {
            revisedIntroduction = text;
            _isLoading = false;
          });
        } else {
          _showErrorSnackBar('Invalid response format');
        }
      } else {
        _showErrorSnackBar(
            'Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to fetch response: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자기소개서 수정'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '수정사항 입력',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _modificationController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '수정사항을 입력하세요',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _generateRevisedIntroduction,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('수정된 자기소개서 생성'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '수정된 자기소개서',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  revisedIntroduction,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
