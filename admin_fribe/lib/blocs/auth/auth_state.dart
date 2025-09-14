part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

final class AuthState extends Equatable {
  final UserModel? currentUser;
  final AuthStatus status;
  final String? errorMessage;

  const AuthState._({
    this.currentUser,
    this.status = AuthStatus.unknown,
    this.errorMessage,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(UserModel user)
    : this._(currentUser: user, status: AuthStatus.authenticated);

  const AuthState.unauthenticated(String? errorMessage)
    : this._(status: AuthStatus.unauthenticated, errorMessage: errorMessage);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [currentUser, status, errorMessage];
}
