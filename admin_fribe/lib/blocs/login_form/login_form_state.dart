part of 'login_form_bloc.dart';

final class LoginFormState extends Equatable {
  final Username name;
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool isLoading;

  const LoginFormState._({
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.isValid,
    required this.isLoading,
  });

  factory LoginFormState.initial() => const LoginFormState._(
    name: Username.pure(),
    email: Email.pure(),
    password: Password.pure(),
    status: FormzSubmissionStatus.initial,
    isValid: false,
    isLoading: false,
  );

  String? get emailErrorText {
    if (email.isPure) return null;
    final emailError = {
      EmailValidationError.empty: 'Email cannot be empty',
      EmailValidationError.invalid: 'Invalid email format',
    };
    return emailError[email.error];
  }

  String? get passwordErrorText {
    if (password.isPure) return null;
    final passwordError = {
      PasswordValidationError.empty: 'Password cannot be empty',
      PasswordValidationError.tooShort:
          'Password needs to be at least 6 characters',
    };
    return passwordError[password.error];
  }

  LoginFormState copyWith({
    Username Function()? name,
    Email Function()? email,
    Password Function()? password,
    FormzSubmissionStatus Function()? status,
    bool Function()? isValid,
    bool Function()? isLoading,
  }) {
    return LoginFormState._(
      name: name?.call() ?? this.name,
      email: email?.call() ?? this.email,
      password: password?.call() ?? this.password,
      status: status?.call() ?? this.status,
      isValid: isValid?.call() ?? this.isValid,
      isLoading: isLoading?.call() ?? this.isLoading,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [name, email, password, status, isValid, isLoading];
  }
}
