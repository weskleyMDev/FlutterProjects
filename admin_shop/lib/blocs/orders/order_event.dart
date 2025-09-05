part of 'order_bloc.dart';

sealed class OrderEvent {
  const OrderEvent();
}

final class OrdersOverviewSubscriptionRequested extends OrderEvent {
  const OrdersOverviewSubscriptionRequested();
}

final class UserOrdersCountRequested extends OrderEvent {
  final String userId;
  const UserOrdersCountRequested(this.userId);
}

final class UserOrdersTotalRequested extends OrderEvent {
  final String userId;
  const UserOrdersTotalRequested(this.userId);
}

final class SetStatusCodeRequested extends OrderEvent {
  final String oid;
  final bool isIncrement;
  const SetStatusCodeRequested(this.oid, this.isIncrement);
}
