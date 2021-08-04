import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/verification/verification_event.dart';
import 'package:happy_chat/data/bloc/verification/verification_state.dart';
import 'package:happy_chat/data/data-provider/authentication-provider.dart';
import 'package:happy_chat/utilities/session.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(InitialVerificationState());
  AuthenticationApi authApi = AuthenticationApi();

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
          Session.write('token', map["data"]["token"].toString());
          yield SuccessVerificationState();
        } else {
          yield FailedVerificationState();
        }
      }
    } catch (e) {
      print(e);
      yield FailedVerificationState();
    }
  }
}
