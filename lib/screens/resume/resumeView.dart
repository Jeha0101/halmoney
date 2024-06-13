import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class ResumeView extends StatefulWidget {
  final String userId;
  final String resumeId;

  const ResumeView({Key? key, required this.userId, required this.resumeId})
      : super(key: key);

  @override
  _ResumeViewState createState() => _ResumeViewState();
}

class _ResumeViewState extends State<ResumeView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _resumeData;
  GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fetchResumeData();
  }

  Future<void> _fetchResumeData() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('user')
          .doc(widget.userId)
          .collection('resumes')
          .doc(widget.resumeId)
          .get();

      setState(() {
        _resumeData = doc.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print("Failed to fetch resume data: $e");
    }
  }

  Future<void> _deleteResume() async {
    try {
      await _firestore
          .collection('user')
          .doc(widget.userId)
          .collection('resumes')
          .doc(widget.resumeId)
          .delete();
      Navigator.of(context).pop();
    } catch (e) {
      print("Failed to delete resume: $e");
    }
  }

  void _copyTextToClipboard() {
    String resumeText = '';
    if (_resumeData != null) {
      resumeText += '${_resumeData!['resumeItem']['name'] ?? '이름 없음'}\n';
      resumeText += '${_resumeData!['resumeItem']['gender'] ?? '성별 없음'}\n';
      resumeText += '${_resumeData!['resumeItem']['dob']}년생\n';
      resumeText += '주소: ${_resumeData!['resumeItem']['address'] ?? '주소 없음'}\n';
      resumeText +=
          '전화번호: ${_resumeData!['resumeItem']['phone'] ?? '전화번호 없음'}\n';
      resumeText += '경력 사항:\n';
      for (var experience in _resumeData!['resumeItem']['workExperiences']) {
        resumeText += '${experience['place']}\n';
        resumeText +=
            '근무 기간: ${experience['startYear']}년 ${experience['startMonth']}월 ~ ${experience['endYear']}년 ${experience['endMonth']}월\n';
        resumeText += '근무 내용: ${experience['description']}\n';
      }
      resumeText +=
          '자기소개서:\n${_resumeData!['resumeItem']['selfIntroduction'] ?? '자기소개 없음'}\n';
    }
    Clipboard.setData(ClipboardData(text: resumeText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이력서 보기'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: Colors.grey,
        ),
      ),
      body: _resumeData == null
          ? Center(child: Text("이력서를 불러오는 중입니다."))
          : Padding(
              padding: const EdgeInsets.all(30.0),
              child: RepaintBoundary(
                key: _repaintBoundaryKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
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
                          child: _resumeData!['resumeItem']['image'] != null
                              ? Image.network(
                                  _resumeData!['resumeItem']['image'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ),
                        SizedBox(width: 35),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _resumeData!['resumeItem']['name'] ?? '이름 없음',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${_resumeData!['resumeItem']['gender'] ?? '성별 없음'}',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${_resumeData!['resumeItem']['dob']}년생',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    //주소, 전화번호란
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
                              '${_resumeData!['resumeItem']['address']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_resumeData!['resumeItem']['phone']}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    //경력란
                    const Text(
                      '경력 사항',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    ...(_resumeData!['resumeItem']['workExperiences']
                            as List<dynamic>)
                        .map((experience) {
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
                              '${experience['place']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '근무 기간   ${experience['startYear']}년 ${experience['startMonth']}월 ~ ${experience['endYear']}년 ${experience['endMonth']}월',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '근무 내용   ${experience['description']}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    Divider(),

                    //자기소개서
                    const SizedBox(height: 10),
                    const Text(
                      '자기소개서',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _resumeData!['resumeItem']['selfIntroduction'] ??
                            '자기소개 없음',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('삭제 확인'),
                        content: Text('해당 이력서를 삭제하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('취소'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                  if (confirmDelete == true) {
                    await _deleteResume();
                  }
                },
                style: ElevatedButton.styleFrom(
                  //primary: Color.fromARGB(250, 51, 51, 255),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  '삭제하기',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _copyTextToClipboard,
                style: ElevatedButton.styleFrom(
                  //color: Color.fromARGB(250, 51, 51, 255),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  '텍스트 복사하기',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
