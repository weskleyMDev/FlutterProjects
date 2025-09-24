part of 'auth_bloc.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState extends Equatable {
  final UserModel? user;
  final AuthStatus status;
  final String? errorMessage;

  const AuthState._({
    required this.user,
    required this.status,
    required this.errorMessage,
  });

  factory AuthState.initial() => const AuthState._(
    user: null,
    status: AuthStatus.initial,
    errorMessage: null,
  );

  factory AuthState.authenticated(UserModel? user) => AuthState._(
    user: user,
    status: AuthStatus.authenticated,
    errorMessage: null,
  );

  factory AuthState.unauthenticated(String? errorMessage) => AuthState._(
    user: null,
    status: AuthStatus.unauthenticated,
    errorMessage: errorMessage,
  );

  @override
  List<Object?> get props => [user, status, errorMessage];
}
