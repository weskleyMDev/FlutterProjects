import 'package:form_bloc/models/app_user.dart';

sealed class AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoggedInState extends AuthState {
  final AppUser? currentUser;
  AuthLoggedInState({required this.currentUser});
}

final class AuthLoggedOutState extends AuthState {}

final class AuthErrorState extends AuthState {
  final Object error;
  AuthErrorState({required this.error});
}
