import 'dart:convert';

enum UserRole { user, admin }

final class AppUser {
  final String id;
  final String email;
  final UserRole role;

  const AppUser._({required this.id, required this.email, required this.role});

  factory AppUser.local({required String id, required String email}) {
    return AppUser._(id: id, email: email, role: UserRole.user);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          role == other.role);

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ role.hashCode;

  @override
  String toString() {
    return 'AppUser{id: $id, email: $email, role: $role}';
  }

  AppUser copyWith({String? id, String? email}) {
    return AppUser._(id: id ?? this.id, email: email ?? this.email, role: role);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'role': role.name};
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    final roleStr = map['role'] as String? ?? 'user';
    return AppUser._(
      id: map['id'] as String,
      email: map['email'] as String,
      role: roleStr == 'admin' ? UserRole.admin : UserRole.user,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
