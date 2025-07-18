// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  final String id;
  final String email;
  final String role;

  AppUser({required this.id, required this.email, this.role = 'user'});

  AppUser copyWith({String? id, String? email, String? role}) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'role': role};
  }

  factory AppUser.fromMap(Map<String, dynamic> map, String uid) {
    return AppUser(
      id: uid,
      email: map['email'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source, String uid) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>, uid);

  @override
  String toString() => 'AppUser(id: $id, email: $email, role: $role)';

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.role == role;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ role.hashCode;
}
