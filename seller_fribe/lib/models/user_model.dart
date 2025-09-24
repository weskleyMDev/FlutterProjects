import 'package:equatable/equatable.dart';

final class UserModel extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isActive;

  const UserModel._({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
  });

  factory UserModel.initial() =>
      const UserModel._(id: '', email: '', role: 'user', isActive: true);

  UserModel copyWith({
    String Function()? id,
    String Function()? email,
    String Function()? role,
    bool Function()? isActive,
  }) => UserModel._(
    id: id?.call() ?? this.id,
    email: email?.call() ?? this.email,
    role: role?.call() ?? this.role,
    isActive: isActive?.call() ?? this.isActive,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'role': role,
    'isActive': isActive,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel._(
    id: map['id'] as String,
    email: map['email'] as String,
    role: map['role'] as String,
    isActive: map['isActive'] as bool,
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, email, role, isActive];
}
