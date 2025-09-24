part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

final class ObscuredToggled extends LoginEvent {
  const ObscuredToggled();

  @override
  List<Object> get props => [];
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();

  @override
  List<Object> get props => [];
}

final class LoginReset extends LoginEvent {
  const LoginReset();

  @override
  List<Object> get props => [];
}
