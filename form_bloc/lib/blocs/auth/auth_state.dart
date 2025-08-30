import 'package:form_bloc/models/app_user.dart';

enum AuthStatus { waiting, success, error }

final class AuthState {
  final AppUser? currentUser;
  final String email;
  final String password;
  final AuthStatus? status;
  final Object? error;

  const AuthState._({
    this.currentUser,
    required this.email,
    required this.password,
    this.status,
    this.error,
  });

  factory AuthState.local() {
    return AuthState._(
      currentUser: null,
      email: '',
      password: '',
      status: null,
      error: null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthState &&
          runtimeType == other.runtimeType &&
          currentUser == other.currentUser &&
          email == other.email &&
          password == other.password &&
          status == other.status &&
          error == other.error);

  @override
  int get hashCode =>
      currentUser.hashCode ^
      email.hashCode ^
      password.hashCode ^
      status.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'AuthState{ currentUser: $currentUser, email: $email, password: $password, status: $status, error: $error }';
  }

  AuthState copyWith({
    AppUser? currentUser,
    String? email,
    String? password,
    AuthStatus? status,
    Object? error,
  }) {
    return AuthState._(
      currentUser: currentUser ?? this.currentUser,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState._(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
