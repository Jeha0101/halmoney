import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FirestoreData/user_Info.dart';
import '../standard_app_bar.dart';
import 'chat_bubble.dart';
import 'chat_message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InterviewChatBot extends StatefulWidget {
  final UserInfo userInfo;
  final String chatDocId;

  InterviewChatBot({
    Key? key,
    required this.userInfo,
    required this.chatDocId,
  }) : super(key: key);

  @override
  State<InterviewChatBot> createState() => _InterviewChatBotState();
}

class _InterviewChatBotState extends State<InterviewChatBot> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String title = 'AI 면접관';
  String? job; // 직무를 저장할 변수
  String? company; // 회사명을 저장할 변수
  bool isReadyMessageShown = false;
  List<ChatMessage> messages = [];
  final ScrollController _messagesViewScroll = ScrollController();
  final ScrollController _messageEditorScroll = ScrollController();
  final TextEditingController _messageFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  void sendMessage(String messageContent) async {
    ChatMessage chatMessage = addNewMessage(messageContent, true);
    if (messageContent.trim().toLowerCase() == "끝내기"){
      print("대화 종료. 모든 대화 호출:");
      messages.forEach((msg) {
        print("${msg.isUserMessage ? '사용자' : 'AI'}: ${msg.messageContent}");
      });
      addNewMessage("대화를 종료합니다. 아래는 대화 내역입니다:", false);
      for (var msg in messages) {
        addNewMessage(
            "${msg.isUserMessage ? '사용자' : 'AI'}: ${msg.messageContent}", false);
        print(msg);
      }
      return;
    }

    if (job == null) {
      // 직무가 입력되지 않았다면, 직무를 저장
      job = messageContent;
      print("직무 저장: $job");
    } else if (company == null) {
      // 회사명이 입력되지 않았다면, 회사명을 저장
      company = messageContent;
      print("회사명 저장: $company");

      // 직무와 회사가 모두 입력되면 /setup API 호출
      await callSetupApi(job!, company!);
    } else {
      // AI와 대화 진행
      try {
        final response = await http.post(
          Uri.parse("http://10.0.2.2:8000/chat"), // API URL
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "message": messageContent, // 사용자가 입력한 메시지
            "history": messages
                .map((msg) => {
              "role": msg.isUserMessage ? "user" : "assistant",
              "content": msg.messageContent,
            })
                .toList(),
          }),
        );

        if (response.statusCode == 200) {
          // 서버 응답 처리
          final responseData = json.decode(utf8.decode(response.bodyBytes));
          final assistantMessage = responseData["assistant_message"];
          addNewMessage(assistantMessage, false); // AI 메시지 추가
        } else {
          print("Chat API 호출 실패: ${response.statusCode}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("AI와의 대화 중 문제가 발생했습니다.")),
          );
        }
      } catch (e) {
        print("Chat API 호출 중 오류 발생: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("AI와의 대화 중 오류가 발생했습니다.")),
        );
      }

    }
    _saveMessage(chatMessage);
    getMessage();
  }

  Future<void> callSetupApi(String job, String company) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/setup"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"job": job, "company": company}),
      );

      if (response.statusCode == 200) {
        print("Setup API 호출 성공: ${response.body}");
      } else {
        print("Setup API 호출 실패: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("설정 API 호출에 실패했습니다.")),
        );
      }
    } catch (e) {
      print("Setup API 호출 중 오류 발생: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("설정 API 호출 중 오류가 발생했습니다.")),
      );
    }
  }

  void getMessage() async{
    String messageContent;
    ChatMessage chatMessage;

    if (job == null) {
      // 직무를 입력받는 단계
      messageContent = '안녕하세요. 저는 당신의 면접 준비를 도와줄 AI 면접관입니다.\n어떤 직무를 준비중이신가요?';
      chatMessage = addNewMessage(messageContent, false);
      _saveMessage(chatMessage);
    } else if (company == null) {
      // 회사명을 입력받는 단계
      messageContent = '좋습니다! 구체적으로 어떤 회사의 면접을 준비하고 계신가요?';
      chatMessage = addNewMessage(messageContent, false);
      _saveMessage(chatMessage);
    } else if (!isReadyMessageShown) {
      // 준비 메시지를 최초로 한 번만 표시
      messageContent = "감사합니다! 면접 준비를 시작합니다.";
      chatMessage = addNewMessage(messageContent, false);
      _saveMessage(chatMessage);
      isReadyMessageShown = true;
      // 약 3초 후 질문 생성 API 호출
      // 질문 생성 API 호출
      Future.delayed(Duration(seconds: 3), () async {
        await fetchFirstQuestion();
      });
    }
  }

  Future<void> fetchFirstQuestion() async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/chat"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "message": "면접 질문을 시작합니다.", // AI에게 질문 요청
          "history": messages
              .map((msg) => {
            "role": msg.isUserMessage ? "user" : "assistant",
            "content": msg.messageContent,
          })
              .toList(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        final assistantMessage = responseData["assistant_message"];
        ChatMessage chatMessage = addNewMessage(assistantMessage, false); // 첫 질문 추가
        _saveMessage(chatMessage);
      } else {
        print("Chat API 호출 실패: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("질문 생성 중 문제가 발생했습니다.")),
        );
      }
    } catch (e) {
      print("질문 생성 중 오류 발생: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("질문 생성 중 오류가 발생했습니다.")),
      );
    }
  }

  ChatMessage addNewMessage(String messageContent, bool isUserMessage) {
    ChatMessage chatMessage = ChatMessage(
        messageContent: messageContent,
        isUserMessage: isUserMessage,
        messageTime: DateTime.now());
    setState(() {
      messages.add(chatMessage);
    });

    Future.delayed(Duration(milliseconds: 100), () {
      _messagesViewScroll.animateTo(
        _messagesViewScroll.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    return chatMessage;
  }

  Future<void> _saveMessage(ChatMessage chatMessage) async {
    try{
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.userInfo.userId)
          .get();
      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty){
        final String docId = documents.first.id;
        print("채팅 문서 id : "+widget.chatDocId);
        final chatDocRef = _firestore
            .collection('user')
            .doc(docId)
            .collection('chatings')
            .doc(widget.chatDocId);

        await chatDocRef.set({
          'lastMessage': chatMessage.messageContent,
          'lastMessageTime': chatMessage.messageTime,
        });

        // chat_messages 컬렉션 내부에 메시지 저장
        final chatMessagesCollection = chatDocRef.collection('chat_messages');
        await chatMessagesCollection.add({
          'messageContent': chatMessage.messageContent,
          'messageTime': chatMessage.messageTime,
          'isUserMessage': chatMessage.isUserMessage,
        });
      } else {
        print("User document not found.");
      }
    } catch (e){
      print("Failed to save chat message : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: title,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _messagesViewScroll,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  messageContent: messages[index].messageContent,
                  isUserMessage: messages[index].isUserMessage,
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageFieldController,
                    scrollController: _messageEditorScroll,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: '답변을 입력하세요',
                      filled: true,
                      fillColor: Color.fromARGB(225, 225, 225, 225),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageFieldController.text.isNotEmpty) {
                      sendMessage(_messageFieldController.text);
                      _messageFieldController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}