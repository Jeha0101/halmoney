import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/extra_resume_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//이력서 데이터
class ResumeItem {
  late String name;
  late String gender;
  late String dob;
  late String address;
  late String phone;
  late List<WorkExperience> workExperiences;
  late List<String> selectedSkills;
  late List<String> selectedStrens;
  late String selfIntroduction;
  late String title;
  File? image;

  ResumeItem({
    required this.name,
    required this.gender,
    required this.dob,
    required this.address,
    required this.phone,
    required this.workExperiences,
    required this.selectedSkills,
    required this.selectedStrens,
    required this.selfIntroduction,
    this.image,
  });

  //이력서 데이터를 Map으로 변환하는 함수
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'dob': dob,
      'address': address,
      'phone': phone,
      'workExperiences': workExperiences.map((e) => e.toMap()).toList(),
      'selfIntroduction': selfIntroduction,
      'image': image?.path, // 이미지 경로를 저장
    };
  }
}

class ResumeEdit extends StatefulWidget {
  final String id;
  final List<String> selectedSkills;
  final List<String> selectedStrens;
  final List<WorkExperience> workExperiences;

  const ResumeEdit({
    Key? key,
    required this.id,
    required this.selectedSkills,
    required this.selectedStrens,
    required this.workExperiences,
  }) : super(key: key);

  @override
  _ResumeEditState createState() => _ResumeEditState();
}

class _ResumeEditState extends State<ResumeEdit> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late ResumeItem resumeItem;
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
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        final DocumentSnapshot ds =
            await _firestore.collection('user').doc(docId).get();

        final data = ds.data() as Map<String, dynamic>;

        // Fetching user information
        final String name = data['name'];
        final String dob = data['dob'].substring(0, 4);
        final String gender = data['gender'];
        final String address = data['address'];
        final String phone = data['phone'];

        // Fetching work experiences
        List<WorkExperience> workExperiences = [];
        for (var experience in widget.workExperiences) {
          workExperiences.add(experience);
        }

        // Fetching AI response
        final response = await _fetchGPTResponse(
          dob: dob,
          gender: gender,
          workExperiences: workExperiences,
          selectedSkills: widget.selectedSkills,
          selectedStrens: widget.selectedStrens,
        );

        setState(() {
          resumeItem = ResumeItem(
            name: name,
            gender: gender,
            dob: dob,
            address: address,
            phone: phone,
            workExperiences: workExperiences,
            selectedSkills: widget.selectedSkills,
            selectedStrens: widget.selectedStrens,
            selfIntroduction: response,
          );
          _selfIntroductionController.text = response;
          _isLoading = false;
        });
      }
    } catch (error) {
      print("Failed to fetch resume data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch resume data: $error")),
      );
    }
  }

  //GPT 자기소개서 작성
  Future<String> _fetchGPTResponse({
    required String dob,
    required String gender,
    required List<WorkExperience> workExperiences,
    required List<String> selectedSkills,
    required List<String> selectedStrens,
  }) async {
    final apiKey = dotenv.get('GPT_API_KEY');
    const endpoint = 'https://api.openai.com/v1/chat/completions';
    const requestsTimeOut = const Duration(seconds: 60);

    String prompt = '''다음 특징을 갖는 사람의 자기소개서 작성 :
    성별:$gender, 생년월:$dob, 경력 :$workExperiences, 기술:$selectedSkills, 장점:$selectedStrens;
    주의 : 성별과 생년월을 언급할 필요는 없다. 공적인 말투.'안녕하세요', '감사합니다'와 같은 인사와 마무리 인사는 모두 생략한다''';

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

  // 이미지 저장
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        resumeItem.image = File(pickedFile.path);
      });
    }
  }

  // 이력서 저장
  Future<void> _saveResume(String title) async {
    final QuerySnapshot result = await _firestore
        .collection('user')
        .where('id', isEqualTo: widget.id)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      final String docId = documents.first.id;

      try {
        final CollectionReference resumesCollection =
            _firestore.collection('user').doc(docId).collection('resumes');

        final DocumentReference newResume = resumesCollection.doc();

        await newResume.set({
          'title': title,
          'resumeItem': resumeItem.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Resume saved successfully")),
        );
      } catch (error) {
        print("Failed to save resume data: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save resume data: $error")),
        );
      }
    }
  }

  // 앱 바 뒤로가기 버튼
  void _goBack() {
    Navigator.pop(context);
  }

  //안드로이드 뒤로가기 버튼
  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('이력서 작성을 취소하시겠습니까?'),
              content: Text('지금까지 작성한 이력서는 저장되지 않습니다.'),
              actions: <Widget>[
                TextButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // 이력서 제목 입력받는 팝업창
  Future<void> _showSaveDialog() async {
    TextEditingController _titleController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('이력서 제목을 입력하세요'),
          content: TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: '이력서 제목',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                _saveResume(_titleController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('이력서 작성'),
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _goBack,
            ),
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
                        'AI 이력서를 생성중입니다',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      // 개인정보란
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2.5,
                                    blurRadius: 10.0,
                                    blurStyle: BlurStyle.inner,
                                  ),
                                ],
                              ),
                              child: resumeItem.image == null
                                  ? const Text(
                                      '사진\n등록',
                                      style: TextStyle(fontSize: 15),
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        resumeItem.image!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resumeItem.name,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                resumeItem.gender,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                resumeItem.dob + '년생',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // 주소, 전화번호란
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '주소',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '전화번호',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resumeItem.address,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                resumeItem.phone,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),

                      // 경력란
                      const SizedBox(height: 10),
                      const Text(
                        '경력 사항',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: resumeItem.workExperiences.map((experience) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            padding: const EdgeInsets.all(15.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${experience.place}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '근무 기간   ${experience.startYear}년 ${experience.startMonth}월 ~ ${experience.endYear}년 ${experience.endMonth}월',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '근무 내용   ${experience.description}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      Divider(),

                      // 자기소개서
                      const SizedBox(height: 10),
                      const Text(
                        '자기소개서',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _selfIntroductionController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '자기소개서를 입력하세요',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _showSaveDialog,
                        child: const Text('저장하기',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(250, 51, 51, 255),
                          minimumSize: const Size(360, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
