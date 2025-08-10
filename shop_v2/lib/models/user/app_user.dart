import 'dart:convert';

class AppUser {
  final String? id;
  final String name;
  final String email;
  final String? imageUrl;
  final String? role;

  AppUser({
    this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    this.role,
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? role,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'role': role ?? 'user',
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String?,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String?,
      role: map['role'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, email: $email, imageUrl: $imageUrl, role: $role)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        role.hashCode;
  }
}
