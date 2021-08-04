import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/signup/signup_event.dart';
import 'package:happy_chat/data/bloc/signup/signup_state.dart';
import 'package:happy_chat/data/data-provider/authentication-provider.dart';
import 'package:happy_chat/utilities/session.dart';

class SignupBloc extends Bloc<SignUpEvent, SignUpState> {
  SignupBloc() : super(InitialSignUpState());
  AuthenticationApi authApi = AuthenticationApi();
  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    try {
      if (event is SignUp) {
        yield LoadingSignUpState();
        var response = await authApi.signUp(event.number);
        await Session.write('phone', event.number.toString());
        if (response.statusCode == 200) {
          yield SuccessSignUpState();
        } else {
          yield FailedSignUpState();
        }
      }
    } catch (e) {
      yield FailedSignUpState();
    }
  }
}
