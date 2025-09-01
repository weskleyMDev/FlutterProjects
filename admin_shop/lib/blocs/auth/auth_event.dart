part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();

  @override
  List<Object?> get props => [];
}

final class UserChangesRequested extends AuthEvent {
  const UserChangesRequested();

  @override
  List<Object?> get props => [];
}
