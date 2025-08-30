import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_event.dart';
import 'package:form_bloc/blocs/auth/auth_state.dart';
import 'package:form_bloc/models/app_user.dart';
import 'package:form_bloc/services/auth/iauth_service.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;
  AuthBloc(this._authService) : super(AuthState.local()) {
    on<StartAuthStreamEvent>(_onFetchUser);
    on<SignInUserEvent>(_onSignIn);
    on<SignUpUserEvent>(_onSignUp);
    on<SignOutUserEvent>(_onSignOut);
  }

  FutureOr<void> _onSignIn(
    SignInUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final email = state.email;
      final password = state.password;
      emit(state.copyWith(status: AuthStatus.waiting));
      await _authService.signIn(email, password);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: e is FirebaseException ? e.message : 'Erro ao realizar login',
        ),
      );
    }
  }

  FutureOr<void> _onSignUp(
    SignUpUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final email = state.email;
      final password = state.password;
      emit(state.copyWith(status: AuthStatus.waiting));
      await _authService.signUp(email, password);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: e is FirebaseException ? e.message : 'Erro ao realizar login',
        ),
      );
    }
  }

  FutureOr<void> _onSignOut(
    SignOutUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.waiting));
      await _authService.signOut();
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: e is FirebaseException ? e.message : 'Erro ao realizar login',
        ),
      );
    }
  }

  FutureOr<void> _onFetchUser(
    StartAuthStreamEvent event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach<AppUser?>(
      _authService.userChanges,
      onData: (user) => state.copyWith(currentUser: user),
      onError: (_, _) => state.copyWith(
        currentUser: null,
        status: AuthStatus.error,
        error: 'Erro ao recuperar usuário',
      ),
    );
  }
}
