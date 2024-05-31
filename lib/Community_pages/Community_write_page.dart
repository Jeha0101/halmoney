import 'package:flutter/material.dart';

class Community_Write extends StatelessWidget {
  Community_Write({super.key});

  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 관리하기 위한 키
  final TextEditingController _titleController = TextEditingController(); // 제목 입력 필드의 컨트롤러
  final TextEditingController _contentController = TextEditingController(); // 내용 입력 필드의 컨트롤러
  final FocusNode _titleFocusNode = FocusNode(); // 제목 입력 필드의 포커스 노드
  final FocusNode _contentFocusNode = FocusNode(); // 내용 입력 필드의 포커스 노드

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('글 쓰기'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로가기 버튼
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: Colors.grey,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 화면의 다른 부분을 탭했을 때 키보드 닫기
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // 폼의 키 설정
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  focusNode: _titleFocusNode, // 제목 입력 필드의 포커스 노드 설정
                  decoration: const InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '제목을 입력하세요'; // 제목 필드 유효성 검사
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _contentController,
                  focusNode: _contentFocusNode, // 내용 입력 필드의 포커스 노드 설정
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: '내용',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '내용을 입력하세요'; // 내용 필드 유효성 검사
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // 폼이 유효하면 제출 처리
                        print('제목: ${_titleController.text}');
                        print('내용: ${_contentController.text}');
                        Navigator.of(context).pop(); // 페이지 종료
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(250, 51, 51, 255), // 배경색
                      foregroundColor: Colors.white, // 텍스트 색상
                    ),
                    child: const Text('등록'),
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
