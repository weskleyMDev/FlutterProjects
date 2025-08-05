import 'dart:convert';

class Message {
  final String id;
  final String? text;
  final String? imageUrl;
  final DateTime createAt;
  final String userId;
  final String userName;
  final String? userImageUrl;

  Message({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.createAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  Message copyWith({
    String? id,
    String? text,
    String? imageUrl,
    DateTime? createAt,
    String? userId,
    String? userName,
    String? userImageUrl,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      createAt: createAt ?? this.createAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImageUrl: userImageUrl ?? this.userImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'createAt': createAt.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      text: map['text'] as String?,
      imageUrl: map['imageUrl'] as String?,
      createAt: DateTime.parse(map['createAt'] as String),
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userImageUrl: map['userImageUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, text: $text, imageUrl: $imageUrl, createAt: $createAt, userId: $userId, userName: $userName, userImageUrl: $userImageUrl)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.imageUrl == imageUrl &&
        other.createAt == createAt &&
        other.userId == userId &&
        other.userName == userName &&
        other.userImageUrl == userImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        imageUrl.hashCode ^
        createAt.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        userImageUrl.hashCode;
  }
}
