part of 'order_bloc.dart';

enum OrdersOverviewStatus { initial, loading, success, failure }

final class OrderState extends Equatable {
  final List<OrderModel> orders;
  final OrdersOverviewStatus status;
  final String? orderError;
  const OrderState({
    required this.orders,
    required this.status,
    required this.orderError,
  });

  const OrderState._({
    required this.orders,
    required this.status,
    required this.orderError,
  });

  factory OrderState.initial() => const OrderState._(
    orders: [],
    status: OrdersOverviewStatus.initial,
    orderError: null,
  );

  factory OrderState.loading({List<OrderModel> orders = const []}) =>
      OrderState._(
        orders: orders,
        status: OrdersOverviewStatus.loading,
        orderError: null,
      );

  factory OrderState.success(List<OrderModel> orders) => OrderState._(
    orders: orders,
    status: OrdersOverviewStatus.success,
    orderError: null,
  );

  factory OrderState.failure(String? orderError) => OrderState._(
    orders: [],
    status: OrdersOverviewStatus.failure,
    orderError: orderError,
  );

  OrderState copyWith({
    List<OrderModel> Function()? orders,
    OrdersOverviewStatus Function()? status,
    String? Function()? orderError,
  }) {
    return OrderState(
      orders: orders != null ? orders() : this.orders,
      status: status != null ? status() : this.status,
      orderError: orderError != null ? orderError() : this.orderError,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [orders, status, orderError];
}
