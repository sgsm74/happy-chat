import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:happy_chat/data/bloc/contacts/contacts_event.dart';
import 'package:happy_chat/data/bloc/contacts/contacts_state.dart';
import 'package:happy_chat/data/data-provider/contacts-provider.dart';
import 'package:http/http.dart';

class ContactsBloc
    extends Bloc<FetchContactsListEvent, FetchContactsListState> {
  ContactsBloc() : super(InitialFetchContatctsList());
  ContactsApi contactsApi = ContactsApi();
  @override
  Stream<FetchContactsListState> mapEventToState(
    FetchContactsListEvent event,
  ) async* {
    try {
      if (event is FetchContactsList) {
        yield LoadingFetchContatctsList();
        Response response = await contactsApi.fetchContacts();
        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          yield SuccessFetchContatctsList(data);
        } else {
          yield FailedFetchContatctsList();
        }
      }
    } catch (e) {
      print(e);
      yield FailedFetchContatctsList();
    }
  }
}
