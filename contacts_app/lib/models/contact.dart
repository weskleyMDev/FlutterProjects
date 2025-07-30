import 'dart:convert';

class Contact implements Comparable<Contact> {
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] ?? '',
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      imagePath: map['imagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  int compareTo(Contact other) {
    return id.compareTo(other.id);
  }
}
