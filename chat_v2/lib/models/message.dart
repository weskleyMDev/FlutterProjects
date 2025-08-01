class Message {
  final String id;
  final String text;
  final DateTime createAt;

  const Message({required this.id, required this.text, required this.createAt});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          createAt == other.createAt);

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ createAt.hashCode;

  @override
  String toString() {
    return 'Message{id: $id, text: $text, createAt: $createAt}';
  }

  Message copyWith({String? id, String? text, DateTime? createAt}) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'createAt': createAt.toIso8601String()};
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      text: map['text'] as String,
      createAt: DateTime.parse(map['createAt'] as String),
    );
  }
}
