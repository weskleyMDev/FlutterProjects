import 'dart:convert';

import 'package:equatable/equatable.dart';

final class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;

  const UserModel._({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory UserModel.empty() =>
      const UserModel._(id: '', name: '', email: '', imageUrl: '');

  UserModel copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? email,
    String Function()? imageUrl,
  }) {
    return UserModel._(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      email: email != null ? email() : this.email,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel._(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, email];
}
