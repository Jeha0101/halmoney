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
    messageBoxColor = Colors.grey;
    messageTextColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: messageLocation,
        child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: messageBoxColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              messageContent,
              style: TextStyle(
                color: messageTextColor,
                fontSize: 16.0,
              ),
            )));
  }
}