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
  ObservableStream<List<CartItem>?> get _cartStream {
    _$_cartStreamAtom.reportRead();
    return super._cartStream;
  }

  @override
  set _cartStream(ObservableStream<List<CartItem>?> value) {
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

  late final _$CartStoreBaseActionController = ActionController(
    name: 'CartStoreBase',
    context: context,
  );

  @override
  void incrementQuantity() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.incrementQuantity',
    );
    try {
      return super.incrementQuantity();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
      name: 'CartStoreBase.decrementQuantity',
    );
    try {
      return super.decrementQuantity();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartItems: ${cartItems},
length: ${length},
quantity: ${quantity},
status: ${status}
    ''';
  }
}
