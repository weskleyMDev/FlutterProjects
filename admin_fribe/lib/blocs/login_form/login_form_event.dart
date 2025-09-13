part of 'login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

final class LoginFormNameChanged extends LoginFormEvent {
  final String name;

  const LoginFormNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

final class LoginFormEmailChanged extends LoginFormEvent {
  final String email;

  const LoginFormEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

final class LoginFormPasswordChanged extends LoginFormEvent {
  final String password;

  const LoginFormPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

final class LoginFormSubmitted extends LoginFormEvent {
  const LoginFormSubmitted();
}
