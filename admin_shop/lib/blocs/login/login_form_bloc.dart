import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

final class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormState()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginFormEmailChanged>(_onLoginFormEmailChanged);
    on<LoginFormPasswordChanged>(_onLoginFormPasswordChanged);
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
  }

  FutureOr<void> _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginFormState> emit,
  ) {
    emit(state.copyWith(isObscure: () => !state.isObscure));
  }

  FutureOr<void> _onLoginFormEmailChanged(
    LoginFormEmailChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final email = event.email.trim();
    final validate = RegExp(
      r'^[a-z0-9._-]+@[a-z0-9-]+\.(com|org|net|gov|edu)(\.[a-z]{2})?$',
    ).hasMatch(email);
    if (email.isEmpty) {
      emit(
        state.copyWith(
          email: () => email,
          errorEmail: () => 'Please enter a email.',
        ),
      );
    } else if (!validate) {
      emit(
        state.copyWith(
          email: () => email,
          errorEmail: () => 'Please enter a valid email.',
        ),
      );
    } else {
      emit(state.copyWith(email: () => email, errorEmail: () => ''));
    }
  }

  FutureOr<void> _onLoginFormPasswordChanged(
    LoginFormPasswordChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final password = event.password.trim();
    if (password.isEmpty) {
      emit(
        state.copyWith(
          password: () => password,
          errorPassword: () => 'Please enter a password.',
        ),
      );
    } else if (password.length < 6) {
      emit(
        state.copyWith(
          password: () => password,
          errorPassword: () => 'Password must be at least 6 characters.',
        ),
      );
    } else {
      emit(state.copyWith(password: () => password, errorPassword: () => ''));
    }
  }

  Future<void> _onLoginFormSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    emit(state.copyWith(loginStatus: () => LoginFormStatus.waiting));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(loginStatus: () => LoginFormStatus.success));
  }
}
