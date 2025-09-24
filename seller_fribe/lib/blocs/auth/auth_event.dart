part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthSubscribeRequested extends AuthEvent {
  const AuthSubscribeRequested();

  @override
  List<Object> get props => [];
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();

  @override
  List<Object> get props => [];
}
