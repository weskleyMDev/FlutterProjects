class AppUser {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;
  final String role;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          imageUrl == other.imageUrl &&
          role == other.role);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      imageUrl.hashCode ^
      role.hashCode;

  @override
  String toString() {
    return 'AppUser{id: $id, name: $name, email: $email, imageUrl: $imageUrl}';
  }

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
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'role': role,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String?,
      role: map['role'] as String,
    );
  }
}
