import 'package:flutter/material.dart';

class Comment {
  final String author;
  final String content;

  Comment({required this.author, required this.content});
}

class CommunityCommentSection extends StatefulWidget {
  const CommunityCommentSection({super.key});

  @override
  _CommunityCommentSectionState createState() => _CommunityCommentSectionState();
}

class _CommunityCommentSectionState extends State<CommunityCommentSection> {
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [];

  void _addComment(String author, String content) {
    setState(() {
      _comments.add(Comment(author: author, content: content));
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 댓글 입력 필드와 버튼
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: '댓글 입력...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    _addComment('사용자', _commentController.text);
                  }
                },
                child: const Text('등록'),
              ),
            ],
          ),
        ),
        // 댓글 리스트
        ListView.builder(
          shrinkWrap: true, // ListView가 Column 안에 있기 때문에 사용
          physics: const NeverScrollableScrollPhysics(), // 스크롤을 Column이 담당하게 함
          itemCount: _comments.length,
          itemBuilder: (context, index) {
            final comment = _comments[index];
            return ListTile(
              title: Text(comment.author),
              subtitle: Text(comment.content),
            );
          },
        ),
      ],
    );
  }
}

class CommunityDetail extends StatelessWidget {
  const CommunityDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Halmoney'),
          backgroundColor: const Color.fromARGB(250, 51, 51, 255),
          toolbarHeight: 35,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  '행복 요양원 어떤가요?',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 420,
                height: 220,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(500, 217, 217, 217), // 라인 색상
                      width: 1.0, // 라인 두께
                    ),
                    top: BorderSide(
                      color: Color.fromARGB(500, 217, 217, 217), // 라인 색상
                      width: 1.0, // 라인 두께
                    ),
                  ),
                ),
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text(
                          "성자신손 오백 년은 우리 황실이요 산고수려 동반도는 우리 본국일세 애국하는 열심의기 북악같이 높고충군하는 일편단심 동해같이 깊어천만인의 오직 한 맘 나라 사랑하여농공상 귀천없이 직분만 다하세우리나라 우리황제 황천이 도우군민공락 만만세에 태평독립하세무궁화 삼천리 화려강산 조선 사람 조선으로 길이 보존하세",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 댓글 섹션 추가
              const CommunityCommentSection(),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const CommunityDetail());
}

