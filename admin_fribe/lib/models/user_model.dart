import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isActive;
  final String role;

  UserModel._({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
    required this.role,
  });

  factory UserModel.empty() {
    return UserModel._(id: '', name: '', email: '', isActive: false, role: 'user');
  }

  UserModel copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? email,
    bool Function()? isActive,
    String Function()? role,
  }) {
    return UserModel._(
      id: id?.call() ?? this.id,
      name: name?.call() ?? this.name,
      email: email?.call() ?? this.email,
      isActive: isActive?.call() ?? this.isActive,
      role: role?.call() ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'isActive': isActive,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel._(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      isActive: map['isActive'] as bool? ?? false,
      role: map['role'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(id: $id, email: $email, isActive: $isActive, role: $role)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.isActive == isActive &&
        other.role == role;
  }

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ isActive.hashCode ^ role.hashCode;
}
