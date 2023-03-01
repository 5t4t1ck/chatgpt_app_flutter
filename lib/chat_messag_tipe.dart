
enum ChatMassageType { user, bot }

class ChatMessage {
  final String text;
  final ChatMassageType chatMessageType;

  ChatMessage({required this.text, required this.chatMessageType});
}
