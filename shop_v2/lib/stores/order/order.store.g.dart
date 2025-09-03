// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on OrderStoreBase, Store {
  Computed<List<OrderModel>>? _$ordersComputed;

  @override
  List<OrderModel> get orders =>
      (_$ordersComputed ??= Computed<List<OrderModel>>(
        () => super.orders,
        name: 'OrderStoreBase.orders',
      )).value;
  Computed<StreamStatus>? _$orderStatusComputed;

  @override
  StreamStatus get orderStatus =>
      (_$orderStatusComputed ??= Computed<StreamStatus>(
        () => super.orderStatus,
        name: 'OrderStoreBase.orderStatus',
      )).value;
  Computed<ObservableMap<String, dynamic>>? _$dataComputed;

  @override
  ObservableMap<String, dynamic> get data =>
      (_$dataComputed ??= Computed<ObservableMap<String, dynamic>>(
        () => super.data,
        name: 'OrderStoreBase.data',
      )).value;

  late final _$_orderStreamAtom = Atom(
    name: 'OrderStoreBase._orderStream',
    context: context,
  );

  @override
  ObservableStream<List<OrderModel>> get _orderStream {
    _$_orderStreamAtom.reportRead();
    return super._orderStream;
  }

  @override
  set _orderStream(ObservableStream<List<OrderModel>> value) {
    _$_orderStreamAtom.reportWrite(value, super._orderStream, () {
      super._orderStream = value;
    });
  }

  late final _$_dataAtom = Atom(name: 'OrderStoreBase._data', context: context);

  @override
  ObservableMap<String, dynamic> get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(ObservableMap<String, dynamic> value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  late final _$fetchProductsForOrderAsyncAction = AsyncAction(
    'OrderStoreBase.fetchProductsForOrder',
    context: context,
  );

  @override
  Future<List<ProductOrder>> fetchProductsForOrder(List<CartItem> items) {
    return _$fetchProductsForOrderAsyncAction.run(
      () => super.fetchProductsForOrder(items),
    );
  }

  late final _$saveOrderAsyncAction = AsyncAction(
    'OrderStoreBase.saveOrder',
    context: context,
  );

  @override
  Future<void> saveOrder() {
    return _$saveOrderAsyncAction.run(() => super.saveOrder());
  }

  late final _$OrderStoreBaseActionController = ActionController(
    name: 'OrderStoreBase',
    context: context,
  );

  @override
  void fetchOrders() {
    final _$actionInfo = _$OrderStoreBaseActionController.startAction(
      name: 'OrderStoreBase.fetchOrders',
    );
    try {
      return super.fetchOrders();
    } finally {
      _$OrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orders: ${orders},
orderStatus: ${orderStatus},
data: ${data}
    ''';
  }
}
