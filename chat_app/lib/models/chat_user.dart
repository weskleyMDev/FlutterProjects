// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatUser {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  ChatUser copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
  }) {
    return ChatUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map, String uid) {
    return ChatUser(
      id: uid,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUser.fromJson(String source, String uid) =>
      ChatUser.fromMap(json.decode(source) as Map<String, dynamic>, uid);

  @override
  String toString() {
    return 'ChatUser(id: $id, name: $name, email: $email, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant ChatUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ imageUrl.hashCode;
  }
}
