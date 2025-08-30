import 'package:form_bloc/models/app_user.dart';

sealed class AuthEvent {}

final class StartAuthStreamEvent extends AuthEvent {}

final class SetEmailEvent extends AuthEvent {
  final String email;
  SetEmailEvent(this.email);
}

final class SetPasswordEvent extends AuthEvent {
  final String password;
  SetPasswordEvent(this.password);
}

final class SignInUserEvent extends AuthEvent {}

final class SignUpUserEvent extends AuthEvent {}

final class SignOutUserEvent extends AuthEvent {}

final class UpdateUserEvent extends AuthEvent {
  final AppUser user;
  UpdateUserEvent(this.user);
}
