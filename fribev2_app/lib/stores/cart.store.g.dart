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

  late final _$CartStoreBaseActionController = ActionController(
    name: 'CartStoreBase',
    context: context,
  );

  @override
  bool addProduct(Product product, [int quantity = 1]) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.addProduct',
    );
    try {
      return super.addProduct(product, quantity);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProductById(String id) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.removeProductById',
    );
    try {
      return super.removeProductById(id);
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
  String toString() {
    return '''
cartList: ${cartList},
total: ${total},
errorMessage: ${errorMessage},
isProductInCart: ${isProductInCart}
    ''';
  }
}
