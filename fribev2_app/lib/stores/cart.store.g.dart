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
  Computed<String>? _$totalAmountComputed;

  @override
  String get totalAmount => (_$totalAmountComputed ??= Computed<String>(
    () => super.totalAmount,
    name: 'CartStoreBase.totalAmount',
  )).value;
  Computed<Map<String, String>>? _$subtotalsComputed;

  @override
  Map<String, String> get subtotals =>
      (_$subtotalsComputed ??= Computed<Map<String, String>>(
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

  late final _$addItemAsyncAction = AsyncAction(
    'CartStoreBase.addItem',
    context: context,
  );

  @override
  Future<void> addItem({required Product product}) {
    return _$addItemAsyncAction.run(() => super.addItem(product: product));
  }

  late final _$showDialogQuantityAsyncAction = AsyncAction(
    'CartStoreBase.showDialogQuantity',
    context: context,
  );

  @override
  Future<bool?> showDialogQuantity({required BuildContext context}) {
    return _$showDialogQuantityAsyncAction.run(
      () => super.showDialogQuantity(context: context),
    );
  }

  late final _$CartStoreBaseActionController = ActionController(
    name: 'CartStoreBase',
    context: context,
  );

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
quantity: ${quantity},
cartList: ${cartList},
itemsCount: ${itemsCount},
totalAmount: ${totalAmount},
subtotals: ${subtotals}
    ''';
  }
}
