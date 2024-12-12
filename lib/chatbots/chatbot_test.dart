import 'package:flutter/material.dart';
import 'package:halmoney/chatbots/chat_bubble.dart';
import 'package:halmoney/chatbots/chat_message.dart';
import 'package:halmoney/standard_app_bar.dart';
import 'package:win32/winsock2.dart';

class ChatBotTest extends StatefulWidget {
  ChatBotTest({super.key});

  @override
  State<ChatBotTest> createState() => _ChatBotTestState();
}

class _ChatBotTestState extends State<ChatBotTest> {
  String title = 'ChatBot';
  List<ChatMessage> messages = [];
  final ScrollController _messagesViewScroll = ScrollController();
  final ScrollController _messageEditorScroll = ScrollController();
  final TextEditingController _messageFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  void sendMessage(String messageContent) {
    ChatMessage chatMessage = addNewMessage(messageContent, true);
    // store the message in firestore
    getMessage();
  }

  void getMessage() {
    String messageContent;
    // get the response from the chatbot
    if (messages.length == 0){
      messageContent = '안녕하세요. 챗봇입니다.\n직무를 입력하세요';
      addNewMessage(messageContent, false);
    }
    else if (messages.length == 2) {
      messageContent = '회사 명을 알려주세요';
      addNewMessage(messageContent, false);
    }
    else {
      messageContent = "임시 메시지입니다."; // 메시지 얻어오기
      addNewMessage(messageContent, false);
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

    print("messages 개수 : "+messages.length.toString());
    print("마지막 메시지 : "+messages[messages.length-1].messageContent);
    return chatMessage;
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
                    isUserMessage: messages[index].isUserMessage
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
                      hintText: '메시지를 입력하세요',
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