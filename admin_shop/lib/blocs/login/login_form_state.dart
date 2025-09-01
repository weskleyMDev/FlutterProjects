part of 'login_form_bloc.dart';

final class LoginFormState extends Equatable {
  final String email;
  final String errorEmail;
  final String password;
  final String errorPassword;
  final String name;
  final String errorName;
  final bool isObscure;
  final String failureMessage;
  final bool isSignInMode;

  const LoginFormState._({
    required this.email,
    required this.errorEmail,
    required this.password,
    required this.errorPassword,
    required this.name,
    required this.errorName,
    required this.isObscure,
    required this.failureMessage,
    required this.isSignInMode,
  });

  factory LoginFormState.initial() => const LoginFormState._(
    email: '',
    errorEmail: '',
    password: '',
    errorPassword: '',
    name: '',
    errorName: '',
    isObscure: true,
    failureMessage: '',
    isSignInMode: true,
  );

  bool get isLoginValid {
    final isEmailValid = email.isNotEmpty && errorEmail.isEmpty;
    final isPasswordValid = password.isNotEmpty && errorPassword.isEmpty;
    return isEmailValid && isPasswordValid;
  }

  bool get isSignUpValid {
    final isEmailValid = email.isNotEmpty && errorEmail.isEmpty;
    final isPasswordValid = password.isNotEmpty && errorPassword.isEmpty;
    final isNameValid = name.isNotEmpty && errorName.isEmpty;
    return isEmailValid && isPasswordValid && isNameValid;
  }

  LoginFormState copyWith({
    String Function()? email,
    String Function()? errorEmail,
    String Function()? password,
    String Function()? errorPassword,
    String Function()? name,
    String Function()? errorName,
    bool Function()? isObscure,
    String Function()? failureMessage,
    bool Function()? isSignInMode,
  }) {
    return LoginFormState._(
      email: email != null ? email() : this.email,
      errorEmail: errorEmail != null ? errorEmail() : this.errorEmail,
      password: password != null ? password() : this.password,
      errorPassword: errorPassword != null
          ? errorPassword()
          : this.errorPassword,
      name: name != null ? name() : this.name,
      errorName: errorName != null ? errorName() : this.errorName,
      isObscure: isObscure != null ? isObscure() : this.isObscure,
      failureMessage: failureMessage != null
          ? failureMessage()
          : this.failureMessage,
      isSignInMode: isSignInMode != null ? isSignInMode() : this.isSignInMode,
    );
  }

  @override
  List<Object?> get props => [
    email,
    errorEmail,
    password,
    errorPassword,
    name,
    errorName,
    isObscure,
    failureMessage,
    isSignInMode,
  ];
}
