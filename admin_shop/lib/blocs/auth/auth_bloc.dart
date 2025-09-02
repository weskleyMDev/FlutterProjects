import 'dart:async';

import 'package:admin_shop/models/user_model.dart';
import 'package:admin_shop/services/auth/iauth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;

  AuthBloc(this._authService) : super(AuthState.initial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<UserChangesRequested>(_onUserChangesRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => AuthStatus.waiting,
        errorMessage: () => null,
      ),
    );
    try {
      await _authService.signIn(email: event.email, password: event.password);
    } catch (e) {
      emit(
        state.copyWith(
          status: () => AuthStatus.failure,
          errorMessage: () =>
              e is FirebaseAuthException ? e.message! : e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => AuthStatus.waiting,
        errorMessage: () => null,
      ),
    );
    try {
      await _authService.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: () => AuthStatus.failure,
          errorMessage: () =>
              e is FirebaseAuthException ? e.message! : e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.signOut();
    emit(AuthState.initial());
  }

  Future<void> _onUserChangesRequested(
    UserChangesRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: () => AuthStatus.waiting));
    await emit.forEach<UserModel?>(
      _authService.userChanges,
      onData: (user) =>
          user != null ? AuthState.success(user: user) : AuthState.initial(),
      onError: (e, _) => AuthState.failure(
        errorMessage: e is FirebaseAuthException ? e.message! : e.toString(),
      ),
    );
  }

}
