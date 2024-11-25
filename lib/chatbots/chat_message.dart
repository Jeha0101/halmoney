class ChatMessage {
  String messageContent;
  bool isUserMessage;
  DateTime messageTime;

  ChatMessage(
      {required this.messageContent,
      required this.isUserMessage,
      required this.messageTime});
}
