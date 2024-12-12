import 'package:flutter/material.dart';
import 'package:halmoney/chatbots/chat_bubble.dart';
import 'package:halmoney/chatbots/chat_message.dart';
import 'package:halmoney/standard_app_bar.dart';
import 'package:win32/winsock2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotTest extends StatefulWidget {
  ChatBotTest({super.key});

  @override
  State<ChatBotTest> createState() => _ChatBotTestState();
}

class _ChatBotTestState extends State<ChatBotTest> {
  String title = 'ChatBot';
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
    // 사용자 메시지를 추가
    ChatMessage userMessage = addNewMessage(messageContent, true);
    if (messageContent.trim().toLowerCase() == "끝내기") {
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
      return; // 더 이상 대화 진행하지 않음
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

    // 다음 질문 생성
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

  void getMessage() async {
    String messageContent;

    if (job == null) {
      // 직무를 입력받는 단계
      messageContent = '안녕하세요. 챗봇입니다.\n직무를 입력하세요';
      addNewMessage(messageContent, false);
    } else if (company == null) {
      // 회사명을 입력받는 단계
      messageContent = '회사 명을 알려주세요';
      addNewMessage(messageContent, false);
    } else if (!isReadyMessageShown) {
      // 준비 메시지를 최초로 한 번만 표시
      messageContent = "감사합니다! 준비를 시작합니다.";
      addNewMessage(messageContent, false);
      isReadyMessageShown = true;

      // 질문 생성 API 호출
      await fetchFirstQuestion();
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
        addNewMessage(assistantMessage, false); // 첫 질문 추가
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
      messageTime: DateTime.now(),
    );

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

    print("messages 개수 : ${messages.length}");
    print("마지막 메시지 : ${messages.last.messageContent}");
    return chatMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: title,
        onBackPressed: () {
          Navigator.pop(context);
          Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => ChatBotTest()),
          );

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