import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/signup/signup_bloc.dart';
import 'package:happy_chat/data/bloc/signup/signup_event.dart';
import 'package:happy_chat/data/bloc/verification/verification_event.dart';
import 'package:happy_chat/data/bloc/verification/verification_state.dart';
import 'package:happy_chat/data/data-provider/authentication-provider.dart';
import 'package:happy_chat/utilities/session.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(InitialVerificationState());
  AuthenticationApi authApi = AuthenticationApi();
  SignupBloc signupBloc = SignupBloc();
  @override
  Stream<VerificationState> mapEventToState(
    VerificationEvent event,
  ) async* {
    try {
      if (event is Verification) {
        yield LoadingVerificationState();
        var response = await authApi.verification(event.code);
        Map<String, dynamic> map = json.decode(response.body);
        if (response.statusCode == 200) {
          print(response.body);
          Session.write('token', map["data"]["token"].toString());
          yield SuccessVerificationState();
        } else {
          yield FailedVerificationState();
        }
      }
      if (event is ResendCode) {
        yield InitialResendCode();
        String number = await Session.read('phone');
        signupBloc.add(SignUp(int.parse(number)));
        yield SuccessResendCode();
        //await Future.delayed(Duration(seconds: 20));
        //yield InitialResendCode();
      }
    } catch (e) {
      print(e);
      yield FailedVerificationState();
    }
  }
}
