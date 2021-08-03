import 'dart:convert';

import 'package:happy_chat/data/api.dart';
import 'package:happy_chat/utilities/session.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ContactsApi {
  Future<http.Response> fetchContacts() async {
    try {
      String token = await Session.read('token');
      final Response response = await http.get(
        Uri.parse(Api.contacts),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ' + token,
        },
      );
      //Map<String, dynamic> map = json.decode(response.body);
      return response;
    } on Exception catch (e) {
      return http.Response(e.toString(), 400);
    }
  }
}
