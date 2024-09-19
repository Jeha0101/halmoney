import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/step4_career.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:halmoney/screens/resume/resumeManage.dart';
import 'package:halmoney/get_user_info/career.dart';
import 'package:halmoney/get_user_info/user_Info.dart';
import 'package:halmoney/screens/resume/user_prompt_factor.dart';

class StepResumeCreate extends StatefulWidget {
  final UserInfo userInfo;
  final UserPromptFactor userPromptFactor;

  StepResumeCreate({
    super.key,
    required this.userInfo,
    required this.userPromptFactor,
  });

  @override
  State<StepResumeCreate> createState() => _StepResumeCreateState();
}

class _StepResumeCreateState extends State<StepResumeCreate> {
  late List<String> selectedFields;
  late String careers;
  late List<String> selectedStrens;
  late int quantity;

  bool _isLoading = true;
  final TextEditingController _selfIntroductionController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchResumeData();
  }

  //사용자 정보 불러오기
  Future<void> _fetchResumeData() async {
    try {
      selectedFields = widget.userPromptFactor.selectedFields;
      careers = widget.userPromptFactor.getCareersString();
      selectedStrens = widget.userPromptFactor.selectedStrens;
      quantity = widget.userPromptFactor.quantity;

      final response = await _fetchGPTResponse(
        selectedFields: selectedFields,
        careers:  careers,
        selectedStrens: selectedStrens,
        quantity: quantity,
      );

      setState(() {
        _selfIntroductionController.text = response;
        _isLoading = false;
      });
    } catch (error) {
      print("Failed to fetch resume data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch resume data: $error")),
      );
    }
  }

  //GPT 자기소개서 작성
  Future<String> _fetchGPTResponse({
    required List<String> selectedFields,
    required String careers,
    required List<String> selectedStrens,
    required int quantity,
  }) async {
    final apiKey = dotenv.get('GPT_API_KEY');
    const endpoint = 'https://api.openai.com/v1/chat/completions';
    const requestsTimeOut = const Duration(seconds: 60);

    String prompt = ''' 중장년층 사용자의 정보를 기반으로 자기소개서를 작성해주는 챗봇입니다.
    다음 가이드에 따라 각 항목은 간결하게, '안녕하세요'는 빼고, 분량이 넘지 않도록 작성해주세요.
    첫번째 문단 - 150 token 내외
    사용자는 $selectedFields 분야에 지원하고자 합니다. 이 분야에 지원하게 된 동기를 작성하세요. 사용자의 경력과 관심사를 바탕으로 자연스럽게 연결해 설명하세요.
    두번째 문단 - 250 token 내외
    사용자의 경력은 다음과 같습니다: $careers. 이러한 경력이 어떻게 지원 분야($selectedFields)와 연관되어 있는지 작성하고, 해당 분야에서 어떤 기여를 할 수 있을지 설명하세요.
    사용자의 장점은 $selectedStrens입니다. 사용자의 장점이 지원 분야에서 어떻게 발휘될 수 있을지 설명하세요. 특히, 이러한 능력이 해당 직무에서 어떤 방식으로 도움이 될지 구체적으로 작성하세요.
    세번째 문단 - 50 token 내외
    지원하는 $selectedFields 분야에서 사용자가 이루고자 하는 구체적인 목표와 다짐을 포함하여 작성하세요. 이 목표가 어떻게 조직에 기여할 수 있을지 설명하세요.
    마지막으로 "감사합니다"로 마무리 인사를 추가하세요.
    ''';

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
          return text;
        } else {
          return 'Failed to fetch response: Invalid response format';
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return 'Failed to fetch response: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Failed to fetch response: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('이력서 작성'),
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: Colors.white,
          ),
          body: _isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xff1044FC),
                ),
                SizedBox(height: 20),
                Text(
                  'AI 자기소개서를 생성중입니다',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: ListView(
              children: [
                const Text(
                  '자기소개서',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _selfIntroductionController,
                  maxLines: 100,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '자기소개서를 입력하세요',
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
