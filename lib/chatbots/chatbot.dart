import 'package:flutter/material.dart';
import 'package:halmoney/chatbots/chat_bubble.dart';
import 'package:halmoney/chatbots/chat_message.dart';
import 'package:halmoney/standard_app_bar.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  String title = 'ChatBot';
  List<ChatMessage> messages = [];
  final ScrollController _messagesViewScroll = ScrollController();
  final ScrollController _messageEditorScroll = ScrollController();
  final TextEditingController _messageFieldController = TextEditingController();

  void sendMessage(String messageContent) {
    ChatMessage chatMessage = addNewMessage(messageContent, true);
    // store the message in firestore
    getMessage();
  }

  void getMessage() {
    // get the response from the chatbot
    String messageContent = '안녕하세요. 챗봇입니다. 어떤 도움이 필요하신가요?';
    addNewMessage(messageContent, false);
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

    print("messages 개수 : ${messages.length}");
    print("마지막 메시지 : ${messages[messages.length-1].messageContent}");
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
                    isUserMessage: messages[index].isUserMessage);
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