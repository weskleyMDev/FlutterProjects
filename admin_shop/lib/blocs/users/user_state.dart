part of 'user_bloc.dart';

enum UserOverviewStatus { initial, loading, success, failure }

final class UserState extends Equatable {
  final List<UserModel> users;
  final UserOverviewStatus status;
  final String? userError;
  const UserState({
    required this.users,
    required this.status,
    required this.userError,
  });

  const UserState._({
    required this.users,
    required this.status,
    required this.userError,
  });

  factory UserState.initial() => const UserState._(
    users: [],
    status: UserOverviewStatus.initial,
    userError: null,
  );

  factory UserState.loading({List<UserModel> users = const []}) => UserState._(
    users: users,
    status: UserOverviewStatus.loading,
    userError: null,
  );

  factory UserState.success(List<UserModel> users) => UserState._(
    users: users,
    status: UserOverviewStatus.success,
    userError: null,
  );

  factory UserState.failure(String? userError) => UserState._(
    users: [],
    status: UserOverviewStatus.failure,
    userError: userError,
  );

  UserState copyWith({
    List<UserModel> Function()? users,
    UserOverviewStatus Function()? status,
    String? Function()? userError,
  }) {
    return UserState(
      users: users != null ? users() : this.users,
      status: status != null ? status() : this.status,
      userError: userError != null ? userError() : this.userError,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [users, status, userError];
}
