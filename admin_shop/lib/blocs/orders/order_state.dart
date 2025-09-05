part of 'order_bloc.dart';

enum OrdersOverviewStatus { initial, loading, success, failure }

enum OrderProgressStatus {
  packing({'en': 'Packing', 'pt': 'Embalando'}),
  shipping({'en': 'Shipping', 'pt': 'Enviando'}),
  delivered({'en': 'Delivered', 'pt': 'Entregue'});

  final Map<String, String> translations;

  const OrderProgressStatus(this.translations);

  String label(String locale) => translations[locale] ?? name;
}

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

  OrderState copyWith({
    List<OrderModel> Function()? orders,
    OrdersOverviewStatus Function()? status,
    String? Function()? orderError,
    Map<String, int> Function()? userOrdersCount,
    Map<String, num> Function()? userOrdersTotal,
  }) {
    return OrderState._(
      orders: orders?.call() ?? this.orders,
      status: status?.call() ?? this.status,
      orderError: orderError?.call() ?? this.orderError,
      userOrdersCount: userOrdersCount?.call() ?? this.userOrdersCount,
      userOrdersTotal: userOrdersTotal?.call() ?? this.userOrdersTotal,
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
