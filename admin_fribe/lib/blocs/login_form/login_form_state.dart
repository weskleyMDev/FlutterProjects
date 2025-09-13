import 'package:admin_fribe/blocs/login_form/validator/email_validator.dart';
import 'package:admin_fribe/blocs/login_form/validator/password_validator.dart';
import 'package:admin_fribe/blocs/login_form/validator/username_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginFormState extends Equatable {
  final Username name;
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;

  const LoginFormState._({
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.isValid,
  });

  factory LoginFormState.initial() => const LoginFormState._(
    name: Username.pure(),
    email: Email.pure(),
    password: Password.pure(),
    status: FormzSubmissionStatus.initial,
    isValid: false,
  );

  LoginFormState copyWith({
    Username Function()? name,
    Email Function()? email,
    Password Function()? password,
    FormzSubmissionStatus Function()? status,
    bool Function()? isValid,
  }) {
    return LoginFormState._(
      name: name?.call() ?? this.name,
      email: email?.call() ?? this.email,
      password: password?.call() ?? this.password,
      status: status?.call() ?? this.status,
      isValid: isValid?.call() ?? this.isValid,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [name, email, password, status, isValid];
  }
}
