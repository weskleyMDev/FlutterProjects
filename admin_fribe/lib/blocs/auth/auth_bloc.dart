import 'package:admin_fribe/models/user_model.dart';
import 'package:admin_fribe/services/auth/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;
  AuthBloc({required IAuthService authService})
    : _authService = authService,
      super(const AuthState.unknown()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.unknown());
    try {
      await emit.forEach<UserModel?>(
        _authService.userChanges,
        onData: (user) {
          if (user != null) {
            return AuthState.authenticated(user);
          } else {
            return const AuthState.unauthenticated(null);
          }
        },
        onError: (e, _) => e is FirebaseAuthException
            ? AuthState.unauthenticated(e.message)
            : AuthState.unauthenticated(e.toString()),
      );
    } catch (e) {
      emit(AuthState.unauthenticated("Unknown error: $e"));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.signOut();
    emit(const AuthState.unknown());
  }
}
