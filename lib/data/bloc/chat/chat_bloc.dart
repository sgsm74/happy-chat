import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/chat/chat_event.dart';
import 'package:happy_chat/data/bloc/chat/chat_state.dart';
import 'package:happy_chat/data/models/message.dart';
import 'package:happy_chat/utilities/mqttclient.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  ChatBloc() : super(InitialChatMessage());

  late MQTTClientWrapper mqttClientWrapper;

  @override
  Stream<ChatMessageState> mapEventToState(
    ChatMessageEvent event,
  ) async* {
    try {
      if (event is SendMessage) {
        var chats = Hive.box<Message>('chats-' + event.userId);
        chats.add(event.message);
      }
    } catch (e) {
      print("asa" + e.toString());

      yield FailedChatMessage();
    }
  }
}
