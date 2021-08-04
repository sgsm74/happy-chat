import 'package:happy_chat/data/models/message.dart';

abstract class ChatMessageEvent {
  ChatMessageEvent();
}

class SendMessage extends ChatMessageEvent {
  Message message;
  String userId;
  String token;
  SendMessage(this.message, this.userId, this.token);
}
