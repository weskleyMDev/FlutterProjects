part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isObscured;
  final String? errorMessage;

  const LoginState._({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isObscured = true,
    this.errorMessage,
  });

  const LoginState.initial() : this._();

  LoginState withObscuredToggled() =>
      LoginState._(isObscured: !isObscured, email: email, password: password);

  LoginState withEmail(String email) =>
      LoginState._(email: EmailInput.dirty(email), password: password);

  LoginState withPassword(String password) =>
      LoginState._(email: email, password: PasswordInput.dirty(password));

  LoginState withSubmissionInProgress() => LoginState._(
    email: email,
    password: password,
    status: FormzSubmissionStatus.inProgress,
  );

  LoginState withSubmissionSuccess() => LoginState._(
    email: email,
    password: password,
    status: FormzSubmissionStatus.success,
  );

  LoginState withSubmissionFailure([String? errorMessage]) => LoginState._(
    email: email,
    password: password,
    status: FormzSubmissionStatus.failure,
    errorMessage: errorMessage,
  );

  bool get isValid => Formz.validate([email, password]);

  String? get emailError {
    if (email.isPure) return null;
    final error = {
      EmailInputError.empty: 'Email is required',
      EmailInputError.invalid: 'Invalid email format',
    };
    return error[email.error];
  }

  String? get passwordError {
    if (password.isPure) return null;
    final error = {
      PasswordInputError.empty: 'Password is required',
      PasswordInputError.short: 'Password is too short',
    };
    return error[password.error];
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isObscured,
    errorMessage,
  ];
}
