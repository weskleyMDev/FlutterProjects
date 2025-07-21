// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on CartStoreBase, Store {
  Computed<Map<String, CartItem>>? _$cartListComputed;

  @override
  Map<String, CartItem> get cartList =>
      (_$cartListComputed ??= Computed<Map<String, CartItem>>(
        () => super.cartList,
        name: 'CartStoreBase.cartList',
      )).value;
  Computed<int>? _$itemsCountComputed;

  @override
  int get itemsCount => (_$itemsCountComputed ??= Computed<int>(
    () => super.itemsCount,
    name: 'CartStoreBase.itemsCount',
  )).value;
  Computed<double>? _$totalAmountComputed;

  @override
  double get totalAmount => (_$totalAmountComputed ??= Computed<double>(
    () => super.totalAmount,
    name: 'CartStoreBase.totalAmount',
  )).value;
  Computed<Map<String, double>>? _$subtotalsComputed;

  @override
  Map<String, double> get subtotals =>
      (_$subtotalsComputed ??= Computed<Map<String, double>>(
        () => super.subtotals,
        name: 'CartStoreBase.subtotals',
      )).value;

  late final _$_cartAtom = Atom(name: 'CartStoreBase._cart', context: context);

  @override
  ObservableMap<String, CartItem> get _cart {
    _$_cartAtom.reportRead();
    return super._cart;
  }

  @override
  set _cart(ObservableMap<String, CartItem> value) {
    _$_cartAtom.reportWrite(value, super._cart, () {
      super._cart = value;
    });
  }

  late final _$CartStoreBaseActionController = ActionController(
    name: 'CartStoreBase',
    context: context,
  );

  @override
  void addItem({required Product product}) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.addItem',
    );
    try {
      return super.addItem(product: product);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem({required String productId}) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.removeItem',
    );
    try {
      return super.removeItem(productId: productId);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.clear',
    );
    try {
      return super.clear();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartList: ${cartList},
itemsCount: ${itemsCount},
totalAmount: ${totalAmount},
subtotals: ${subtotals}
    ''';
  }
}
