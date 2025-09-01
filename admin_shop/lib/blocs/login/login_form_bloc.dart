import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

final class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormState.initial()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginFormEmailChanged>(_onLoginFormEmailChanged);
    on<LoginFormPasswordChanged>(_onLoginFormPasswordChanged);
    on<LoginFormNameChanged>(_onLoginFormNameChanged);
    on<ClearLoginFormFields>(_onClearLoginFormFields);
    on<ToggleLoginFormMode>(_onToggleLoginFormMode);
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

  FutureOr<void> _onLoginFormNameChanged(
    LoginFormNameChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final name = event.name.trim();
    if (name.isEmpty) {
      emit(
        state.copyWith(
          name: () => name,
          errorName: () => 'Please enter a name.',
        ),
      );
    } else if (name.length < 4) {
      emit(
        state.copyWith(
          name: () => name,
          errorName: () => 'Name must be at least 4 characters.',
        ),
      );
    } else {
      emit(state.copyWith(name: () => name, errorName: () => ''));
    }
  }

  FutureOr<void> _onClearLoginFormFields(
    ClearLoginFormFields event,
    Emitter<LoginFormState> emit,
  ) {
    emit(LoginFormState.initial());
  }

  FutureOr<void> _onToggleLoginFormMode(
    ToggleLoginFormMode event,
    Emitter<LoginFormState> emit,
  ) {
    emit(state.copyWith(isSignInMode: () => !state.isSignInMode));
  }
}
