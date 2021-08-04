import 'package:happy_chat/data/models/message.dart';

abstract class PrepareMessagesState {
  PrepareMessagesState();
}

class InitialPrepareMessages extends PrepareMessagesState {
  InitialPrepareMessages();
}

class LoadingPrepareMessages extends PrepareMessagesState {
  LoadingPrepareMessages();
}

class SuccessPrepareMessages extends PrepareMessagesState {
  List<Message> data;
  SuccessPrepareMessages(this.data);
}

class FailedPrepareMessages extends PrepareMessagesState {
  FailedPrepareMessages();
}
