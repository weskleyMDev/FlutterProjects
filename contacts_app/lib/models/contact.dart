import 'dart:convert';

class Contact {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String imagePath;

  const Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imagePath,
  });

  String toJson() => json.encode(toLocalMap());

  factory Contact.fromJson(String source, String cid) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>, cid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          imagePath == other.imagePath);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      imagePath.hashCode;

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, email: $email, phone: $phone, imagePath: $imagePath}';
  }

  Contact copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? imagePath,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toLocalMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
    };
  }

  Map<String, dynamic> toCloudMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
    };
  }

  factory Contact.fromMap(Map<String, dynamic>? map, String cid) {
    return Contact(
      id: cid,
      name: map?['name'] as String,
      email: map?['email'] as String,
      phone: map?['phone'] as String,
      imagePath: map?['imagePath'] as String,
    );
  }
}
