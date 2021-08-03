import 'package:flutter/material.dart';
import 'package:happy_chat/data/models/message.dart';
import 'package:happy_chat/utilities/constants.dart';
import 'dart:math' as math;

import 'package:happy_chat/utilities/mqttclient.dart';

class ChatView extends StatefulWidget {
  final String name;
  final String token;

  const ChatView({Key? key, required this.name, required this.token})
      : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Message> messages = [];
  int id = 1;
  TextEditingController controller = TextEditingController();
  late MQTTClientWrapper mqttClientWrapper;

  @override
  void initState() {
    super.initState();
    mqttClientWrapper = MQTTClientWrapper(widget.token);
    mqttClientWrapper.prepareMqttClient();
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 55.0,
      color: Color(0xffFADDD7),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              textDirection: TextDirection.rtl,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'نوشتن پیام...',
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(
                  color: Constants.kHintColor,
                ),
              ),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Constants.kTextColor,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    mqttClientWrapper.publishMessage(controller.text);
                    messages.add(
                      Message(
                        id: id++,
                        content: controller.text,
                        isMe: true,
                        date: DateTime.now(),
                      ),
                    );

                    controller.text = '';
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Constants.kTextColor,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Text(
                  "بازگشت",
                  style: TextStyle(
                    color: Constants.kTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Constants.kArrowBackIcon,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Constants.kTextColor,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
        backgroundColor: Constants.kBackgroundColor,
        elevation: 0,
      ),
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
              child: messages.isNotEmpty
                  ? ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          margin: messages[index].isMe
                              ? EdgeInsets.only(
                                  left: 70, top: 10, bottom: 10, right: 10)
                              : EdgeInsets.only(
                                  right: 70, top: 10, bottom: 10, left: 10),
                          decoration: BoxDecoration(
                            color: messages[index].isMe
                                ? Constants.kSenderMessageBackgroundColor
                                : Constants.kReceiverMessageBackgroundColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            messages[index].content,
                            textDirection: TextDirection.rtl,
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 164,
                            height: 171,
                            child: Image.asset("assets/portal.png"),
                          ),
                          Text(
                            "هنوز به این دنیا وارد نشدی.",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Constants.kTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "یه پرتال بزن به گوشی رفیقت.",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Constants.kTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
