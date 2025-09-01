part of 'auth_bloc.dart';

enum AuthStatus { initial, waiting, success, failure }

final class AuthState extends Equatable {
  final UserModel? user;
  final AuthStatus status;
  final String? errorMessage;

  const AuthState._({this.user, required this.status, this.errorMessage});

  factory AuthState.initial() => const AuthState._(
    user: null,
    status: AuthStatus.initial,
    errorMessage: null,
  );

  factory AuthState.success({required UserModel user}) =>
      AuthState._(user: user, status: AuthStatus.success, errorMessage: null);

  factory AuthState.failure({required String errorMessage}) => AuthState._(
    user: null,
    status: AuthStatus.failure,
    errorMessage: errorMessage,
  );

  AuthState copyWith({
    UserModel? Function()? user,
    AuthStatus Function()? status,
    String? Function()? errorMessage,
  }) {
    return AuthState._(
      user: user != null ? user() : this.user,
      status: status != null ? status() : this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [user, status, errorMessage];
}
