abstract class ChatMessageState {
  ChatMessageState();
}

class InitialChatMessage extends ChatMessageState {
  InitialChatMessage();
}

class LoadingChatMessage extends ChatMessageState {
  LoadingChatMessage();
}

class SuccessChatMessage extends ChatMessageState {
  SuccessChatMessage();
}

class FailedChatMessage extends ChatMessageState {
  FailedChatMessage();
}
