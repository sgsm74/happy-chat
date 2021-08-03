import 'dart:convert';

class Message {
  int id;
  String content;
  bool isMe;
  DateTime date;
  Message({
    required this.id,
    required this.content,
    required this.isMe,
    required this.date,
  });

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
  }
}
