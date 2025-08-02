import 'dart:convert';

class Message {
  final String id;
  final String text;
  final String? imageUrl;
  final DateTime createAt;

  Message({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.createAt,
  });

  Message copyWith({
    String? id,
    String? text,
    String? imageUrl,
    DateTime? createAt,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'createAt': createAt.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      text: map['text'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      createAt: DateTime.parse(map['createAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, text: $text, imageUrl: $imageUrl, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.imageUrl == imageUrl &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ imageUrl.hashCode ^ createAt.hashCode;
  }
}
