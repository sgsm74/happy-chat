import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/messages/messages_event.dart';
import 'package:happy_chat/data/bloc/messages/messages_state.dart';
import 'package:happy_chat/data/models/message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessagesBloc extends Bloc<PrepareMessagesEvent, PrepareMessagesState> {
  MessagesBloc() : super(InitialPrepareMessages());

  @override
  Stream<PrepareMessagesState> mapEventToState(
    PrepareMessagesEvent event,
  ) async* {
    try {
      if (event is PrepareMessages) {
        var messages = await Hive.openBox<Message>('chats-' + event.userId);
        if (messages.values.isNotEmpty) {
          /* print(messages.values.); */
          //List<Message> messages = for
          yield SuccessPrepareMessages(messages.values.toList());
        } else {
          print("empty");
          yield InitialPrepareMessages();
        }
      }
    } catch (e) {
      print("asa" + e.toString());

      yield FailedPrepareMessages();
    }
  }
}
