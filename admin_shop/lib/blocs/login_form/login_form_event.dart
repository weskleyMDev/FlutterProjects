part of 'login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

final class LoginFormEmailChanged extends LoginFormEvent {
  const LoginFormEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class LoginFormPasswordChanged extends LoginFormEvent {
  const LoginFormPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginFormNameChanged extends LoginFormEvent {
  const LoginFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class TogglePasswordVisibility extends LoginFormEvent {
  const TogglePasswordVisibility();
  @override
  List<Object> get props => [];
}

final class ClearLoginFormFields extends LoginFormEvent {
  const ClearLoginFormFields();
  @override
  List<Object> get props => [];
}

final class ToggleLoginFormMode extends LoginFormEvent {
  const ToggleLoginFormMode();
  @override
  List<Object> get props => [];
}
