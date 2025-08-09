class AppUser {
  final String? id;
  final String name;
  final String email;
  final String imageUrl;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          imageUrl == other.imageUrl);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ imageUrl.hashCode;

  @override
  String toString() {
    return 'AppUser{id: $id, name: $name, email: $email, imageUrl: $imageUrl}';
  }

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'imageUrl': imageUrl};
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String?,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
