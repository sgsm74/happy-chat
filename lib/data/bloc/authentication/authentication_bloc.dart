import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/authentication/authentication_event.dart';
import 'package:happy_chat/data/bloc/authentication/authentication_state.dart';
import 'package:happy_chat/utilities/session.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(InitialAuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    try {
      if (event is Authentication) {
        String token = await Session.read('token');
        if (token != '') {
          yield SuccessAuthenticationState();
        } else {
          yield FailedAuthenticationState();
        }
      }
    } catch (e) {
      print(e);
      yield FailedAuthenticationState();
    }
  }
}
