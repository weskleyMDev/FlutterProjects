import 'package:form_bloc/models/app_user.dart';

sealed class AuthEvent {}

final class FetchUserEvent extends AuthEvent {}

final class SignInUserEvent extends AuthEvent {
  final String email;
  final String password;
  SignInUserEvent({required this.email, required this.password});
}

final class SignUpUserEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpUserEvent({required this.email, required this.password});
}

final class SignOutUserEvent extends AuthEvent {}

final class AuthErrorEvent extends AuthEvent {
  final Object error;
  AuthErrorEvent({required this.error});
}

final class UpdateUserEvent extends AuthEvent {
  final AppUser user;
  UpdateUserEvent(this.user);
}
