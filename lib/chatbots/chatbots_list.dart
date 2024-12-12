import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/chatbots/interview_chatbot.dart';
import 'package:halmoney/standard_app_bar.dart';
import 'package:intl/intl.dart';
import '../FirestoreData/user_Info.dart';

class ChatbotsList extends StatefulWidget {
  final UserInfo userInfo;

  const ChatbotsList({super.key, required this.userInfo});

  @override
  _ChatbotsListState createState() => _ChatbotsListState();
}

class _ChatbotsListState extends State<ChatbotsList> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> chatingsInfo = [];
  String chatDocId = "";

  @override
  void initState() {
    super.initState();
    _loadChatingsInfo();
  }

  Future<void> _newChating() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.userInfo.userId)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isNotEmpty) {
        final String docId = documents.first.id;
        print(docId);

        final chatingsCollection =
        _firestore.collection('user').doc(docId).collection('chatings');

        final chatDocRef = chatingsCollection.doc();
        chatDocId = chatDocRef.id;
        await chatDocRef.set({
          'lastMessage': "채팅이 생성되었습니다.",
          'lastMessageTime': DateTime.now(),
        });
      } else {
        print("User document not found.");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getChatingInfo() async {
    // try {
    //   final QuerySnapshot result = await _firestore
    //       .collection('user')
    //       .where('id', isEqualTo: widget.userInfo.userId)
    //       .get();
    //   final List<DocumentSnapshot> documents = result.docs;
    //
    //   if (documents.isNotEmpty){
    //     final String docId = documents.first.id;
    //     QuerySnapshot querySnapshot = await _firestore
    //         .collection('user')
    //         .doc(docId)
    //         .collection('chatings')
    //         .orderBy('lastMessageTime', descending: true)
    //         .get();
    //     setState(() {
    //       chatingsInfo = querySnapshot.docs;
    //     });
    //   }
    //   final docSnapshot = await _firestore
    //       .collection('user')
    //       .doc(widget.userInfo.userId)
    //       .collection('chatings')
    //       .doc(chatDocId)
    //       .get();
    //
    //   if (docSnapshot.exists) {
    //     final data = docSnapshot.data() as Map<String, dynamic>;
    //     return ChatingInfo(
    //       chatDocId: chatDocId,
    //       lastMessage: data['lastMessage'] ?? "",
    //       lastMessageTime: (data['lastMessageTime'] as Timestamp).toDate(),
    //     );
    //   } else {
    //     throw Exception("Chat document does not exist.");
    //   }
    // } catch (e) {
    //   print("Failed to fetch chat document: $e");
    //   rethrow;
    // }
  }

  Future<void> _loadChatingsInfo() async {
    // try {
    //   final querySnapshot = await _firestore
    //       .collection('user')
    //       .doc(widget.userInfo.userId)
    //       .collection('chatings')
    //       .get();
    //
    //   if (querySnapshot.docs.isEmpty) {
    //     setState(() {
    //       chatingsInfo = [];
    //     });
    //     return;
    //   }
    //
    //   final List<Future<ChatingInfo>> futures = querySnapshot.docs.map((doc) {
    //     return _getChatingInfo(doc.id);
    //   }).toList();
    //
    //   final results = await Future.wait(futures);
    //
    //   setState(() {
    //     chatingsInfo = results;
    //   });
    // } catch (e) {
    //   print("Failed to load chatings info: $e");
    // }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadChatingsInfo();
  // }

  String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    if (dateTime.year == now.year) {
      return DateFormat('MM.dd a h:mm', 'ko').format(dateTime);
    } else {
      return DateFormat('yy.MM.dd a h:mm', 'ko').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: StandardAppBar(
          title: '채팅 목록',
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child:
              //chatingsInfo.isEmpty
            //      ?
            Center(child: Text('채팅 기록이 없습니다.'))
            //       : ListView.builder(
            //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //     itemCount: chatingsInfo.length,
            //     itemBuilder: (context, index) {
            //       final chatingInfo = chatingsInfo[index];
            //       final formattedTime =
            //       formatMessageTime(chatingInfo.lastMessageTime);
            //
            //       return ListTile(
            //         title: Text(chatingInfo.lastMessage),
            //         subtitle: Text(formattedTime),
            //         trailing: Icon(Icons.arrow_forward_ios),
            //         onTap: () {
            //           print("Selected chat document ID: ${chatingInfo.chatDocId}");
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => InterviewChatBot(
            //                 userInfo: widget.userInfo,
            //                 chatDocId: chatingInfo.chatDocId,
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              left: 15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 100, 100, 255),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  await _newChating();
                  if (chatDocId.isNotEmpty) {
                    print("채팅 문서 id : $chatDocId");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InterviewChatBot(
                          userInfo: widget.userInfo,
                          chatDocId: chatDocId,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('채팅방 생성에 실패했습니다. 다시 시도해주세요.'),
                      ),
                    );
                  }
                },
                child: const Text(
                  '새로운 채팅 시작하기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatingInfo {
  final String chatDocId;
  final String lastMessage;
  final DateTime lastMessageTime;

  ChatingInfo({
    required this.chatDocId,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}
