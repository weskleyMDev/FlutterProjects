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
