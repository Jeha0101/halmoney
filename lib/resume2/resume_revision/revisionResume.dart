import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ResumeView2 extends StatefulWidget {
  final String id;
  final String resumeId;
  final int num;
  final String firstParagraph;
  final String secondParagraph;
  final String thirdParagraph;

  const ResumeView2({
    super.key,
    required this.id,
    required this.resumeId,
    required this.num,
    required this.firstParagraph,
    required this.secondParagraph,
    required this.thirdParagraph,
  });

  @override
  _ResumeViewState createState() => _ResumeViewState();
}
class _ResumeViewState extends State<ResumeView2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _resumeData;
  final GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fetchResumeData();
  }



  Future<void> _fetchResumeData() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        DocumentSnapshot doc = await _firestore
            .collection('user')
            .doc(docId)
            .collection('resumes')
            .doc(widget.resumeId)
            .get();

        setState(() {
          _resumeData = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Failed to fetch resume data: $e");
    }
  }

  Future<void> _deleteResume() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        await _firestore
            .collection('user')
            .doc(docId)
            .collection('resumes')
            .doc(widget.resumeId)
            .delete();
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      print("Failed to delete resume: $e");
    }
  }

  Future<void> _applyForJob() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        await _firestore.collection('user').doc(docId).collection('users_attendance').add({
          'num': _resumeData!['resumeItem']['num'],
          'id': widget.id,
          'resumeId': widget.resumeId,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('지원이 완료되었습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Failed to apply for job: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('지원에 실패했습니다. 다시 시도해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  void _copyTextToClipboard() {
    String resumeText = '';
    if (_resumeData != null) {
      resumeText += '이름 : ${_resumeData!['resumeItem']['name'] ?? '이름 없음'}\n';
      resumeText += '성별 : ${_resumeData!['resumeItem']['gender'] ?? '성별 없음'}\n';
      resumeText += '나이 : ${_resumeData!['resumeItem']['dob']}년생\n';
      resumeText += '주소 : ${_resumeData!['resumeItem']['address'] ?? '주소 없음'}\n';
      resumeText +=
      '전화번호: ${_resumeData!['resumeItem']['phone'] ?? '전화번호 없음'}\n';
      resumeText += '\n경력 사항:\n';
      for (var experience in _resumeData!['resumeItem']['workExperiences']) {
        resumeText += '[${experience['place']}]\n';
        resumeText +=
        '근무 기간: ${experience['startYear']}년 ${experience['startMonth']}월 ~ ${experience['endYear']}년 ${experience['endMonth']}월\n';
        resumeText += '근무 내용: ${experience['description']}\n';
      }
      resumeText +=
      '\n자기소개서:\n${_resumeData!['resumeItem']['selfIntroduction'] ?? '자기소개 없음'}\n';
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
          ? const Center(child: Text("이력서를 불러오는 중입니다."))
          : Padding(
        padding: const EdgeInsets.all(30.0),
        child: RepaintBoundary(
          key: _repaintBoundaryKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _resumeData!['resumeItem']['name'] ?? '이름 없음',
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_resumeData!['resumeItem']['gender'] ?? '성별 없음'}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_resumeData!['resumeItem']['dob']}년생',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              //주소, 전화번호란
              Row(
                children: [
                  const Column(
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
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_resumeData!['resumeItem']['address']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${_resumeData!['resumeItem']['phone']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(
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
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '근무 기간   ${experience['startYear']}년 ${experience['startMonth']}월 ~ ${experience['endYear']}년 ${experience['endMonth']}월',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '근무 내용   ${experience['description']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(),

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
                  style: const TextStyle(fontSize: 15),
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
                  _applyForJob();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 51, 51, 255)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 15.0)),
                ),
                child: const Text(
                  '지원하기',
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _copyTextToClipboard();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('텍스트가 복사되었습니다'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 51, 51, 255)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 15.0)),
                ),
                child: const Text(
                  '텍스트 복사하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
