part of 'login_form_bloc.dart';

enum LoginFormStatus { initial, waiting, success, failure }

final class LoginFormState extends Equatable {
  final String email;
  final String errorEmail;
  final String password;
  final String errorPassword;
  final bool isObscure;
  final LoginFormStatus loginStatus;
  final String failureMessage;

  const LoginFormState({
    this.email = '',
    this.errorEmail = '',
    this.password = '',
    this.errorPassword = '',
    this.isObscure = true,
    this.loginStatus = LoginFormStatus.initial,
    this.failureMessage = '',
  });

  bool get isFormValid {
    final isEmailValid = email.isNotEmpty && errorEmail.isEmpty;
    final isPasswordValid = password.isNotEmpty && errorPassword.isEmpty;
    return isEmailValid &&
        isPasswordValid &&
        loginStatus != LoginFormStatus.waiting;
  }

  LoginFormState copyWith({
    String Function()? email,
    String Function()? errorEmail,
    String Function()? password,
    String Function()? errorPassword,
    bool Function()? isObscure,
    LoginFormStatus Function()? loginStatus,
    String Function()? failureMessage,
  }) {
    return LoginFormState(
      email: email != null ? email() : this.email,
      errorEmail: errorEmail != null ? errorEmail() : this.errorEmail,
      password: password != null ? password() : this.password,
      errorPassword: errorPassword != null
          ? errorPassword()
          : this.errorPassword,
      isObscure: isObscure != null ? isObscure() : this.isObscure,
      loginStatus: loginStatus != null ? loginStatus() : this.loginStatus,
      failureMessage: failureMessage != null
          ? failureMessage()
          : this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    errorEmail,
    password,
    errorPassword,
    isObscure,
    loginStatus,
    failureMessage,
  ];
}
