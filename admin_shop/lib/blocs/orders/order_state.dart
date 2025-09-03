part of 'order_bloc.dart';

enum OrdersOverviewStatus { initial, loading, success, failure }

final class OrderState extends Equatable {
  final List<OrderModel> orders;
  final OrdersOverviewStatus status;
  final String? orderError;
  final Map<String, int> userOrdersCount;
  final Map<String, num> userOrdersTotal;

  const OrderState._({
    required this.orders,
    required this.status,
    required this.orderError,
    Map<String, int>? userOrdersCount,
    Map<String, num>? userOrdersTotal,
  }) : userOrdersCount = userOrdersCount ?? const {},
       userOrdersTotal = userOrdersTotal ?? const {};

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
    Map<String, int> Function()? userOrdersCount,
    Map<String, num> Function()? userOrdersTotal,
  }) {
    return OrderState._(
      orders: orders != null ? orders() : this.orders,
      status: status != null ? status() : this.status,
      orderError: orderError != null ? orderError() : this.orderError,
      userOrdersCount: userOrdersCount != null
          ? userOrdersCount()
          : this.userOrdersCount,
      userOrdersTotal: userOrdersTotal != null
          ? userOrdersTotal()
          : this.userOrdersTotal,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    orders,
    status,
    orderError,
    userOrdersCount,
    userOrdersTotal,
  ];
}
