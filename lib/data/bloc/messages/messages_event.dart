abstract class PrepareMessagesEvent {
  PrepareMessagesEvent();
}

class PrepareMessages extends PrepareMessagesEvent {
  String userId;
  PrepareMessages(this.userId);
}
