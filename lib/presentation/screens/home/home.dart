import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chat/data/bloc/contacts/contacts_bloc.dart';
import 'package:happy_chat/data/bloc/contacts/contacts_event.dart';
import 'package:happy_chat/data/bloc/contacts/contacts_state.dart';
import 'package:happy_chat/presentation/screens/chat/chat.dart';
import 'package:happy_chat/utilities/constants.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsBloc()..add(FetchContactsList()),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: Material(
              shape: CircleBorder(),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                child: Image.asset("assets/user-images/rick.png"),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search_rounded,
                color: Constants.kTextColor,
                size: 30,
              ),
            ),
          ],
          backgroundColor: Constants.kBackgroundColor,
          elevation: 0,
        ),
        body:
            Container(child: BlocBuilder<ContactsBloc, FetchContactsListState>(
          builder: (context, state) {
            if (state is LoadingFetchContatctsList) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xffF5DFD9),
                  backgroundColor: Color(0xffDA7E70),
                  strokeWidth: 1.5,
                ),
              );
            } else if (state is SuccessFetchContatctsList)
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Constants.kBorderColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatView(
                                    name: state.data["data"][index]["name"]
                                        .toString(),
                                    token: state.data["data"][index]["token"]
                                        .toString(),
                                  )),
                        );
                      },
                      subtitle: Text(
                        "...هنوز پیامی ارسال نکرده اید",
                        textAlign: TextAlign.right,
                      ),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: Image.asset("assets/user-images/rick.png"),
                      ),
                      title: Text(
                        state.data["data"][index]["name"].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Text(
                        "هیچگاه",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              );
            else {
              return Text("failed");
            }
          },
        )),
      ),
    );
  }
}
