import 'dart:convert';

import 'package:happy_chat/data/models/message.dart';
import 'package:happy_chat/utilities/mqqt-detail.dart';
import 'package:happy_chat/utilities/session.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTClientWrapper {
  late MqttServerClient client;
  String userToken, userId;
  late String otpToken;
  int id = 0;
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  MQTTClientWrapper(this.userToken, this.userId);

  prepareMqttClient() async {
    _setupMqttClient();
    otpToken = await Session.read('token');
    await _connectClient();
    _subscribeToTopic(MQQTDetail.subscribeToTopic(otpToken, userToken));
  }

  void publishMessage(String message) {
    _publishMessage(message);
  }

  Future<void> _connectClient() async {
    try {
      print('MQTTClientWrapper::Mosquitto client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      print('MQTTClientWrapper::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('MQTTClientWrapper::Mosquitto client connected');
    } else {
      print(
          'MQTTClientWrapper::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(MQQTDetail.ip, '#', MQQTDetail.port);
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    client.connectionMessage = MqttConnectMessage()
      ..authenticateAs(MQQTDetail.username, MQQTDetail.password);
  }

  void _subscribeToTopic(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;

      String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String decodeMessage = Utf8Decoder().convert(message.codeUnits);

      print("MQTTClientWrapper::GOT A NEW MESSAGE $decodeMessage");
      saveResponse(decodeMessage);
    });
  }

  saveResponse(String content) async {
    Box<Message> contactsBox = Hive.box<Message>('chats-' + userId);
    contactsBox.add(
      Message(
        content: content,
        date: DateTime.now(),
        id: id++,
        isMe: false,
      ),
    );
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addUTF8String(message);

    print(
        'MQTTClientWrapper::Publishing message $message to topic ${MQQTDetail.publishToTopic(otpToken, userToken)}');

    client.publishMessage(
      MQQTDetail.publishToTopic(otpToken, userToken),
      MqttQos.atLeastOnce,
      builder.payload!,
    );
  }

  void _onSubscribed(String topic) {
    print('MQTTClientWrapper::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print(
        'MQTTClientWrapper::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print(
          'MQTTClientWrapper::OnDisconnected callback is solicited, this is correct');
    }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
  }
}

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}
enum MqttSubscriptionState { IDLE, SUBSCRIBED }
