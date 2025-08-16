// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on CartStoreBase, Store {
  Computed<ObservableList<CartItem>>? _$cartItemsComputed;

  @override
  ObservableList<CartItem> get cartItems =>
      (_$cartItemsComputed ??= Computed<ObservableList<CartItem>>(
        () => super.cartItems,
        name: 'CartStoreBase.cartItems',
      )).value;
  Computed<int>? _$lengthComputed;

  @override
  int get length => (_$lengthComputed ??= Computed<int>(
    () => super.length,
    name: 'CartStoreBase.length',
  )).value;
  Computed<int>? _$quantityComputed;

  @override
  int get quantity => (_$quantityComputed ??= Computed<int>(
    () => super.quantity,
    name: 'CartStoreBase.quantity',
  )).value;
  Computed<double>? _$subtotalComputed;

  @override
  double get subtotal => (_$subtotalComputed ??= Computed<double>(
    () => super.subtotal,
    name: 'CartStoreBase.subtotal',
  )).value;
  Computed<double>? _$totalComputed;

  @override
  double get total => (_$totalComputed ??= Computed<double>(
    () => super.total,
    name: 'CartStoreBase.total',
  )).value;
  Computed<double>? _$discountComputed;

  @override
  double get discount => (_$discountComputed ??= Computed<double>(
    () => super.discount,
    name: 'CartStoreBase.discount',
  )).value;
  Computed<double>? _$shippingComputed;

  @override
  double get shipping => (_$shippingComputed ??= Computed<double>(
    () => super.shipping,
    name: 'CartStoreBase.shipping',
  )).value;
  Computed<int>? _$percentComputed;

  @override
  int get percent => (_$percentComputed ??= Computed<int>(
    () => super.percent,
    name: 'CartStoreBase.percent',
  )).value;
  Computed<ObservableStream<List<CartItem>>>? _$cartStreamComputed;

  @override
  ObservableStream<List<CartItem>> get cartStream =>
      (_$cartStreamComputed ??= Computed<ObservableStream<List<CartItem>>>(
        () => super.cartStream,
        name: 'CartStoreBase.cartStream',
      )).value;
  Computed<StreamStatus>? _$statusComputed;

  @override
  StreamStatus get status => (_$statusComputed ??= Computed<StreamStatus>(
    () => super.status,
    name: 'CartStoreBase.status',
  )).value;

  late final _$_cartStreamAtom = Atom(
    name: 'CartStoreBase._cartStream',
    context: context,
  );

  @override
  ObservableStream<List<CartItem>> get _cartStream {
    _$_cartStreamAtom.reportRead();
    return super._cartStream;
  }

  @override
  set _cartStream(ObservableStream<List<CartItem>> value) {
    _$_cartStreamAtom.reportWrite(value, super._cartStream, () {
      super._cartStream = value;
    });
  }

  late final _$_cartItemsAtom = Atom(
    name: 'CartStoreBase._cartItems',
    context: context,
  );

  @override
  ObservableList<CartItem> get _cartItems {
    _$_cartItemsAtom.reportRead();
    return super._cartItems;
  }

  @override
  set _cartItems(ObservableList<CartItem> value) {
    _$_cartItemsAtom.reportWrite(value, super._cartItems, () {
      super._cartItems = value;
    });
  }

  late final _$_quantityAtom = Atom(
    name: 'CartStoreBase._quantity',
    context: context,
  );

  @override
  int get _quantity {
    _$_quantityAtom.reportRead();
    return super._quantity;
  }

  @override
  set _quantity(int value) {
    _$_quantityAtom.reportWrite(value, super._quantity, () {
      super._quantity = value;
    });
  }

  late final _$_subtotalAtom = Atom(
    name: 'CartStoreBase._subtotal',
    context: context,
  );

  @override
  double get _subtotal {
    _$_subtotalAtom.reportRead();
    return super._subtotal;
  }

  @override
  set _subtotal(double value) {
    _$_subtotalAtom.reportWrite(value, super._subtotal, () {
      super._subtotal = value;
    });
  }

  late final _$_totalAtom = Atom(
    name: 'CartStoreBase._total',
    context: context,
  );

  @override
  double get _total {
    _$_totalAtom.reportRead();
    return super._total;
  }

  @override
  set _total(double value) {
    _$_totalAtom.reportWrite(value, super._total, () {
      super._total = value;
    });
  }

  late final _$_discountAtom = Atom(
    name: 'CartStoreBase._discount',
    context: context,
  );

  @override
  double get _discount {
    _$_discountAtom.reportRead();
    return super._discount;
  }

  @override
  set _discount(double value) {
    _$_discountAtom.reportWrite(value, super._discount, () {
      super._discount = value;
    });
  }

  late final _$_shippingAtom = Atom(
    name: 'CartStoreBase._shipping',
    context: context,
  );

  @override
  double get _shipping {
    _$_shippingAtom.reportRead();
    return super._shipping;
  }

  @override
  set _shipping(double value) {
    _$_shippingAtom.reportWrite(value, super._shipping, () {
      super._shipping = value;
    });
  }

  late final _$_percentAtom = Atom(
    name: 'CartStoreBase._percent',
    context: context,
  );

  @override
  int get _percent {
    _$_percentAtom.reportRead();
    return super._percent;
  }

  @override
  set _percent(int value) {
    _$_percentAtom.reportWrite(value, super._percent, () {
      super._percent = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'CartStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getCouponAsyncAction = AsyncAction(
    'CartStoreBase.getCoupon',
    context: context,
  );

  @override
  Future<void> getCoupon(String coupon) {
    return _$getCouponAsyncAction.run(() => super.getCoupon(coupon));
  }

  late final _$addToCartAsyncAction = AsyncAction(
    'CartStoreBase.addToCart',
    context: context,
  );

  @override
  Future<void> addToCart(ProductModel product, int index, String category) {
    return _$addToCartAsyncAction.run(
      () => super.addToCart(product, index, category),
    );
  }

  late final _$removeByIdAsyncAction = AsyncAction(
    'CartStoreBase.removeById',
    context: context,
  );

  @override
  Future<void> removeById(String id, String uid) {
    return _$removeByIdAsyncAction.run(() => super.removeById(id, uid));
  }

  late final _$incrementQuantityAsyncAction = AsyncAction(
    'CartStoreBase.incrementQuantity',
    context: context,
  );

  @override
  Future<void> incrementQuantity(CartItem cartItem) {
    return _$incrementQuantityAsyncAction.run(
      () => super.incrementQuantity(cartItem),
    );
  }

  late final _$decrementQuantityAsyncAction = AsyncAction(
    'CartStoreBase.decrementQuantity',
    context: context,
  );

  @override
  Future<void> decrementQuantity(CartItem cartItem) {
    return _$decrementQuantityAsyncAction.run(
      () => super.decrementQuantity(cartItem),
    );
  }

  late final _$clearCartAsyncAction = AsyncAction(
    'CartStoreBase.clearCart',
    context: context,
  );

  @override
  Future<void> clearCart() {
    return _$clearCartAsyncAction.run(() => super.clearCart());
  }

  late final _$CartStoreBaseActionController = ActionController(
    name: 'CartStoreBase',
    context: context,
  );

  @override
  void calcCartValues() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.calcCartValues',
    );
    try {
      return super.calcCartValues();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetCart() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.resetCart',
    );
    try {
      return super.resetCart();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
cartItems: ${cartItems},
length: ${length},
quantity: ${quantity},
subtotal: ${subtotal},
total: ${total},
discount: ${discount},
shipping: ${shipping},
percent: ${percent},
cartStream: ${cartStream},
status: ${status}
    ''';
  }
}
