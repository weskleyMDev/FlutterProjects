// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessage {
  final String id;
  final String text;
  final DateTime createAt;

  final String userId;
  final String userName;
  final String userImage;

  ChatMessage({
    required this.id,
    required this.text,
    required this.createAt,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    DateTime? createAt,
    String? userId,
    String? userName,
    String? userImage,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      createAt: createAt ?? this.createAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'createAt': createAt.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      text: map['text'] as String,
      createAt: DateTime.parse(map['createAt'] as String),
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, text: $text, createAt: $createAt, userId: $userId, userName: $userName, userImage: $userImage)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.text == text &&
      other.createAt == createAt &&
      other.userId == userId &&
      other.userName == userName &&
      other.userImage == userImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      text.hashCode ^
      createAt.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      userImage.hashCode;
  }
}
