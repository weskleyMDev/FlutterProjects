import 'dart:convert';

class AppUser {
  final String id;
  final String email;
  final String role;
  final bool isActive;

  AppUser({
    required this.id,
    required this.email,
    this.role = 'user',
    this.isActive = true,
  });

  AppUser copyWith({String? id, String? email, String? role, bool? isActive}) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'role': role,
      'isActive': isActive,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map, String uid) {
    return AppUser(
      id: uid,
      email: map['email'] as String,
      role: map['role'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source, String uid) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>, uid);

  @override
  String toString() =>
      'AppUser(id: $id, email: $email, role: $role, isActive: $isActive)';

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.role == role &&
        other.isActive == isActive;
  }

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ role.hashCode ^ isActive.hashCode;
}
