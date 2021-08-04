import 'dart:convert';

import 'package:hive/hive.dart';
part 'message.g.dart';

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String content;

  @HiveField(2)
  bool isMe;

  @HiveField(3)
  DateTime date;
  Message({
    required this.id,
    required this.content,
    required this.isMe,
    required this.date,
  });

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      id: jsonData['id'],
      content: jsonData['content'],
      isMe: jsonData['isMe'],
      date: jsonData['date'],
    );
  }

  static Map<String, dynamic> toMap(Message message) => {
        'id': message.id,
        'content': message.content,
        'isMe': message.isMe,
        'date': message.date,
      };

  static String encode(List<Message> messages) => json.encode(
        messages
            .map<Map<String, dynamic>>((message) => Message.toMap(message))
            .toList(),
      );

  static List<Message> decode(String messages) =>
      (json.decode(messages) as List<dynamic>)
          .map<Message>((item) => Message.fromJson(item))
          .toList();

/* 
  Message copyWith({
    int? id,
    String? content,
    bool? isMe,
    DateTime? date,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      isMe: isMe ?? this.isMe,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isMe': isMe,
      'date': date.millisecondsSinceEpoch,
    };
  } 

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      content: map['content'],
      isMe: map['isMe'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, content: $content, isMe: $isMe, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.content == content &&
        other.isMe == isMe &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ content.hashCode ^ isMe.hashCode ^ date.hashCode;
  } */
}
