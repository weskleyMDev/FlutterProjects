import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_event.dart';
import 'package:form_bloc/blocs/auth/auth_state.dart';
import 'package:form_bloc/models/app_user.dart';
import 'package:form_bloc/services/auth/iauth_service.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;
  StreamSubscription? _authSubscription;
  AppUser? _lastUser;
  AuthBloc(this._authService) : super(AuthInitialState()) {
    on<FetchUserEvent>(_onFetchUser);
    on<SignInUserEvent>(_onSignIn);
    on<SignUpUserEvent>(_onSignUp);
    on<SignOutUserEvent>(_onSignOut);
    on<UpdateUserEvent>(_onUpdateUser);
    on<AuthErrorEvent>(_onAuthError);
  }

  Future<void> _onFetchUser(
    FetchUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final user = _authService.currentUser;

      if (user != null) {
        emit(AuthLoggedInState(currentUser: user));
      } else {
        emit(AuthLoggedOutState());
      }

      await _authSubscription?.cancel();
      _authSubscription = _authService.userChanges.listen(
        (user) {
          if (isClosed) return;
          if (user != _lastUser) {
            _lastUser = user;
            if (user != null) {
              add(UpdateUserEvent(user));
            } else {
              add(SignOutUserEvent());
            }
          }
        },
        onError: (e) {
          if (!isClosed) {
            add(AuthErrorEvent(error: e));
          }
        },
      );
    } catch (e) {
      emit(AuthErrorState(error: e));
    }
  }

  Future<void> _onSignIn(SignInUserEvent event, Emitter<AuthState> emit) async {
    try {
      await _authService.signIn(event.email, event.password);

      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        emit(AuthLoadingState());
        emit(AuthLoggedInState(currentUser: currentUser));
      } else {
        emit(AuthLoggedOutState());
      }
    } catch (e) {
      emit(
        AuthErrorState(
          error: e is FirebaseAuthException
              ? e.message!
              : Exception('Unknown error: $e'),
        ),
      );
    }
  }

  Future<void> _onSignUp(SignUpUserEvent event, Emitter<AuthState> emit) async {
    try {
      await _authService.signUp(event.email, event.password);

      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        emit(AuthLoadingState());
        emit(AuthLoggedInState(currentUser: currentUser));
      } else {
        emit(AuthLoggedOutState());
      }
    } catch (e) {
      emit(
        AuthErrorState(
          error: e is FirebaseAuthException
              ? e.message!
              : Exception('Unknown error: $e'),
        ),
      );
    }
  }

  Future<void> _onSignOut(
    SignOutUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.signOut();
      emit(AuthLoadingState());
      emit(AuthLoggedOutState());
    } catch (e) {
      emit(
        AuthErrorState(
          error: e is FirebaseAuthException
              ? e.message!
              : Exception('Unknown error: $e'),
        ),
      );
    }
  }

  void _onUpdateUser(UpdateUserEvent event, Emitter<AuthState> emit) {
    emit(AuthLoggedInState(currentUser: event.user));
  }

  void _onAuthError(AuthErrorEvent event, Emitter<AuthState> emit) {
    emit(AuthErrorState(error: event.error));
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
