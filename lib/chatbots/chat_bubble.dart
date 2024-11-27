import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String messageContent;
  final bool isUserMessage;
  Alignment messageLocation = Alignment.centerLeft;
  Color messageBoxColor = Colors.grey;
  Color messageTextColor = Colors.black;

  ChatBubble({super.key, required this.messageContent, required this.isUserMessage}){
    if (isUserMessage) {
      setUserMessage();
    }
    else {
      setBotMessage();
    }
  }

  void setUserMessage(){
    messageLocation = Alignment.centerRight;
    messageBoxColor = Color.fromARGB(250, 51, 51, 255);
    messageTextColor = Colors.white;
  }

  void setBotMessage(){
    messageLocation = Alignment.centerLeft;
    messageBoxColor = Color.fromARGB(225, 225, 225, 225);
    messageTextColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: messageLocation,
        child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(13.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8, // 최대 가로 길이 제한
            ),
            decoration: BoxDecoration(
              color: messageBoxColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              messageContent,
              style: TextStyle(
                color: messageTextColor,
                fontSize: 18.0,
              ),
            )));
  }
}