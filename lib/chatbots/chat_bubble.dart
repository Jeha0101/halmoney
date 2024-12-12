import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatBubble extends StatefulWidget {
  final String messageContent;
  final bool isUserMessage;

  const ChatBubble({
    super.key,
    required this.messageContent,
    required this.isUserMessage,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String displayedText = "";
  Alignment messageLocation = Alignment.centerLeft;
  Color messageBoxColor = Colors.grey;
  Color messageTextColor = Colors.black;
  late FlutterTts chatbotTts;

  @override
  void initState() {
    super.initState();

    chatbotTts = FlutterTts();
    initializeTts();

    if (widget.isUserMessage) {
      setUserMessage();
      displayedText = widget.messageContent;
    } else {
      setBotMessage();
      startTypingAndSpeaking();
    }
  }

  Future<void> initializeTts() async {
    await chatbotTts.setLanguage("ko-KR");
    await chatbotTts.setVolume(1.0);
    await chatbotTts.setSpeechRate(0.5);
    await chatbotTts.setPitch(1.0);
  }

  void startTypingAndSpeaking() async {
    await Future.wait([
      startTypingAnimation(),
      speak(widget.messageContent),
    ]);
  }

  Future<void> startTypingAnimation() async {
    for (int i = 0; i <= widget.messageContent.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        displayedText = widget.messageContent.substring(0, i);
      });
    }
  }

  Future<void> speak(String text) async {
    await chatbotTts.speak(text);
    }

  @override
  void dispose() {
    chatbotTts.stop();
    super.dispose();
  }

  void setUserMessage() {
    messageLocation = Alignment.centerRight;
    messageBoxColor = Color.fromARGB(250, 51, 51, 255);
    messageTextColor = Colors.white;
  }

  void setBotMessage() {
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
          displayedText,
          style: TextStyle(
            color: messageTextColor,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}