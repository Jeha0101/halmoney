import 'package:flutter/material.dart';
import 'package:halmoney/chatbots/chat_bubble.dart';
import 'package:halmoney/chatbots/chat_message.dart';

class ChatBot extends StatefulWidget {
  ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
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
    String messageContent = 'Hello, I am a chatbot. How can I help you today?';
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
    print("messages 개수 : "+messages.length.toString());
    print("마지막 메시지 : "+messages[messages.length-1].messageContent);
    return chatMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
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