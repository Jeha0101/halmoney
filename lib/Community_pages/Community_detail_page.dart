import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comment {
  final String author;
  final String content;

  Comment({
    required this.author,
    required this.content,
  });
}

class CommunityCommentSection extends StatefulWidget {
  final String author;
  final String content;
  final String title;
  final String contents;
  final String id;

  const CommunityCommentSection({
    required this.author,
    required this.content,
    required this.title,
    required this.contents,
    required this.id,
    Key? key,
  }) : super(key: key);
  @override
  _CommunityCommentSectionState createState() => _CommunityCommentSectionState();
}

class _CommunityCommentSectionState extends State<CommunityCommentSection> {
  final TextEditingController _commentController = TextEditingController();
   List<Comment> _comments = [];
   List<Map<String, dynamic>> comments_= [];

  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('community')
          .where('title', isEqualTo: widget.title)
          .get();

      if (result.docs.isNotEmpty) {
        final DocumentSnapshot document = result.docs.first;
        final String documentId = document.id;
        final QuerySnapshot commentsQuery = await FirebaseFirestore.instance
            .collection('community')
            .doc(documentId)
            .collection('comments')
            .get();
        print(commentsQuery);

        if (commentsQuery.docs.isNotEmpty) {
          setState(() {
            comments_ = commentsQuery.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final timestamp = (data['timestamp'] as Timestamp).toDate().toString();
              return {
                'author': data['author'] ?? 'No Author',
                'content': data['content'] ?? 'No Content',
                'timestamp':timestamp,
              };
            }).toList();
            print(comments_);
          });
        }
      }
    } catch (error) {
      print("Failed to fetch comments: $error");
    }
  }



void _addComment(String author, String content) async {
  setState(() {
    _comments.add(Comment(author: author, content: content));
  });
  _commentController.clear();

  // Firestore에 댓글 저장
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('community')
      .where('title', isEqualTo: widget.title)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    DocumentReference postDocRef = querySnapshot.docs.first.reference;
    postDocRef.collection('comments').add({
      'author': author,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
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
                    _addComment(widget.author, _commentController.text);
                    _fetchComments();
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
          itemCount: comments_.length,
          itemBuilder: (context, index) {
            final comment = comments_[index];
            return ListTile(
              title: Text(comment['author']??'NO',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment['content']??'NOOO',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,)
                  ),
                  Text(comment['timestamp'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(250, 51, 51, 255))
                  ),

                ],
              )

            );
          },
        ),
      ],
    );
  }
}

class CommunityDetail extends StatefulWidget {

  final String title;
  final String contents;
  final String id;

  const CommunityDetail({

    required this.title,
    required this.contents,
    required this.id,
    Key? key,
  }) : super(key: key);
  _CommunityDetailState createState() => _CommunityDetailState();
}

  class _CommunityDetailState extends State<CommunityDetail>{
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('커뮤니티'),
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    widget.title,
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
                  child:  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Text(
                            widget.contents,
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
                CommunityCommentSection(
                    author: widget.id,
                    content: '',
                    title: widget.title,
                    contents: widget.contents,
                    id: widget.id)

                // 댓글 섹션 추가

              ],
            ),
          ),
        ),
      );
    }
  }




