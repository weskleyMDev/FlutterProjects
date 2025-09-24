import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/models/user_model.dart';
import 'package:seller_fribe/services/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;
  AuthBloc({required IAuthService authService})
    : _authService = authService,
      super(AuthState.initial()) {
    on<AuthSubscribeRequested>(_onAuthSubscribeRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthSubscribeRequested(
    AuthSubscribeRequested event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach<UserModel?>(
      _authService.userChanges,
      onData: (user) {
        if (user != null) {
          return AuthState.authenticated(user);
        } else {
          return AuthState.unauthenticated("User is not authenticated");
        }
      },
      onError: (e, _) => e is FirebaseAuthException
          ? AuthState.unauthenticated(e.message)
          : AuthState.unauthenticated(e.toString()),
    );
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.signOut();
    emit(AuthState.unauthenticated('User logged out'));
  }
}
