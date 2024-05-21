import 'package:flutter/material.dart';
class Comment {
  final String author;
  final String content;

  Comment({required this.author, required this.content});
}

class CommunityComment_Write extends StatefulWidget {
  @override
  _CommunityCommentSectionState createState() => _CommunityCommentSectionState();
}

class _CommunityCommentSectionState extends State<CommunityComment_Write> {
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: '댓글 입력...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    _addComment('사용자', _commentController.text);
                  }
                },
                child: Text('등록'),
              ),
            ],
          ),
        ),
        // 댓글 리스트
        Expanded(
          child: ListView.builder(
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              final comment = _comments[index];
              return ListTile(
                title: Text(comment.author),
                subtitle: Text(comment.content),
              );
            },
          ),
        ),
      ],
    );
  }
}
