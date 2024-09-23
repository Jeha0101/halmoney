import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Community_Write extends StatelessWidget {
  Community_Write({Key? key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  // Firestore 인스턴스 생성
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 데이터를 Firestore에 추가하는 메소드
  Future<void> _addPostToFirestore() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestore.collection('community').add({
          'title': _titleController.text,
          'contents': _contentController.text,
          'timestamp': Timestamp.now(), // 예시로 timestamp 추가
        });
        // 데이터가 성공적으로 추가되었음을 사용자에게 보여줄 수도 있음
        ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
          const SnackBar(content: Text('글이 등록되었습니다.')),
        );
        Navigator.of(_formKey.currentContext!).pop(); // 페이지 종료
      } catch (e) {
        // 데이터 추가 중 에러 발생 시 처리
        ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
          const SnackBar(content: Text('글 등록에 실패했습니다. 다시 시도해 주세요.')),
        );
        print('Firestore에 데이터 추가 중 에러 발생: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: Colors.grey,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    decoration: const InputDecoration(
                      labelText: '제목',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '제목을 입력하세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _contentController,
                    focusNode: _contentFocusNode,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      labelText: '내용',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '내용을 입력하세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _addPostToFirestore, // 메소드 호출
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('등록'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}