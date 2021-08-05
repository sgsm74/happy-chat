import 'dart:convert';
import 'package:happy_chat/data/api.dart';
import 'package:happy_chat/utilities/session.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AuthenticationApi {
  Future<http.Response> signUp(int phoneNumber) async {
    try {
      final Response response = await http.post(
        Uri.parse(Api.sendVerificationCode),
        body: jsonEncode(<String, dynamic>{
          'phone': phoneNumber,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return response;
    } on Exception catch (e) {
      return http.Response(e.toString(), 400);
    }
  }

  Future<http.Response> verification(String password) async {
    try {
      String username = await Session.read('phone');
      final Response response = await http.post(
        Uri.parse(Api.phoneVerification),
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      return response;
    } on Exception catch (e) {
      return http.Response(e.toString(), 400);
    }
  }
}
