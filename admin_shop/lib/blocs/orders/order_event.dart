part of 'order_bloc.dart';

sealed class OrderEvent {
  const OrderEvent();
}

final class OrdersOverviewSubscriptionRequested extends OrderEvent {
  const OrdersOverviewSubscriptionRequested();
}
