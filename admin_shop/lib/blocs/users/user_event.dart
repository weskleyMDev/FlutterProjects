part of 'user_bloc.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UsersOverviewSubscriptionRequested extends UserEvent {
  const UsersOverviewSubscriptionRequested();
}
