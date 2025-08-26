// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on CartStoreBase, Store {
  Computed<ObservableList<CartItem>>? _$cartListComputed;

  @override
  ObservableList<CartItem> get cartList =>
      (_$cartListComputed ??= Computed<ObservableList<CartItem>>(
        () => super.cartList,
        name: 'CartStoreBase.cartList',
      )).value;
  Computed<double>? _$totalComputed;

  @override
  double get total => (_$totalComputed ??= Computed<double>(
    () => super.total,
    name: 'CartStoreBase.total',
  )).value;
  Computed<double>? _$remainingComputed;

  @override
  double get remaining => (_$remainingComputed ??= Computed<double>(
    () => super.remaining,
    name: 'CartStoreBase.remaining',
  )).value;
  Computed<String?>? _$errorMessageComputed;

  @override
  String? get errorMessage => (_$errorMessageComputed ??= Computed<String?>(
    () => super.errorMessage,
    name: 'CartStoreBase.errorMessage',
  )).value;
  Computed<bool Function(Product)>? _$isProductInCartComputed;

  @override
  bool Function(Product) get isProductInCart =>
      (_$isProductInCartComputed ??= Computed<bool Function(Product)>(
        () => super.isProductInCart,
        name: 'CartStoreBase.isProductInCart',
      )).value;

  late final _$_cartListAtom = Atom(
    name: 'CartStoreBase._cartList',
    context: context,
  );

  @override
  ObservableList<CartItem> get _cartList {
    _$_cartListAtom.reportRead();
    return super._cartList;
  }

  @override
  set _cartList(ObservableList<CartItem> value) {
    _$_cartListAtom.reportWrite(value, super._cartList, () {
      super._cartList = value;
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

  late final _$quantityAtom = Atom(
    name: 'CartStoreBase.quantity',
    context: context,
  );

  @override
  String get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(String value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  late final _$_remainingAtom = Atom(
    name: 'CartStoreBase._remaining',
    context: context,
  );

  @override
  Decimal get _remaining {
    _$_remainingAtom.reportRead();
    return super._remaining;
  }

  @override
  set _remaining(Decimal value) {
    _$_remainingAtom.reportWrite(value, super._remaining, () {
      super._remaining = value;
    });
  }

  late final _$_errorMessageAtom = Atom(
    name: 'CartStoreBase._errorMessage',
    context: context,
  );

  @override
  String? get _errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$updateQuantityAsyncAction = AsyncAction(
    'CartStoreBase.updateQuantity',
    context: context,
  );

  @override
  Future<bool> updateQuantity(BuildContext context, String cid) {
    return _$updateQuantityAsyncAction.run(
      () => super.updateQuantity(context, cid),
    );
  }

  late final _$CartStoreBaseActionController = ActionController(
    name: 'CartStoreBase',
    context: context,
  );

  @override
  bool addProduct(BuildContext context, Product product) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.addProduct',
    );
    try {
      return super.addProduct(context, product);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemaining(BuildContext context) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.setRemaining',
    );
    try {
      return super.setRemaining(context);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProductById(BuildContext context, String id) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.removeProductById',
    );
    try {
      return super.removeProductById(context, id);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setTotal() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase._setTotal',
    );
    try {
      return super._setTotal();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity(String productId) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.incrementQuantity',
    );
    try {
      return super.incrementQuantity(productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity(String productId) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.decrementQuantity',
    );
    try {
      return super.decrementQuantity(productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.clearCart',
    );
    try {
      return super.clearCart();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.clearErrorMessage',
    );
    try {
      return super.clearErrorMessage();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCartStore() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.clearCartStore',
    );
    try {
      return super.clearCartStore();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quantity: ${quantity},
cartList: ${cartList},
total: ${total},
remaining: ${remaining},
errorMessage: ${errorMessage},
isProductInCart: ${isProductInCart}
    ''';
  }
}
