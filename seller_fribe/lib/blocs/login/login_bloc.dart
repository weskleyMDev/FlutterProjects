import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:seller_fribe/blocs/login/validator/email_input.dart';
import 'package:seller_fribe/blocs/login/validator/password_input.dart';
import 'package:seller_fribe/services/auth/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthService _authService;
  LoginBloc({required IAuthService authService})
    : _authService = authService,
      super(const LoginState.initial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ObscuredToggled>((event, emit) {
      emit(state.withObscuredToggled());
    });
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginReset>(_onLoginReset);
  }

  FutureOr<void> _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.withEmail(event.email));
  }

  FutureOr<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.withPassword(event.password));
  }

  FutureOr<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.withSubmissionInProgress());
    try {
      await _authService.signIn(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.withSubmissionSuccess());
      await Future.delayed(Duration(milliseconds: 300));
      emit(const LoginState.initial());
    } catch (e) {
      e is FirebaseAuthException
          ? emit(state.withSubmissionFailure(e.message))
          : emit(state.withSubmissionFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoginReset(
    LoginReset event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginState.initial());
  }
}
