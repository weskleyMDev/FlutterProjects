// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockStore on StockStoreBase, Store {
  Computed<Stream<List<Product>>>? _$productsComputed;

  @override
  Stream<List<Product>> get products =>
      (_$productsComputed ??= Computed<Stream<List<Product>>>(
        () => super.products,
        name: 'StockStoreBase.products',
      )).value;

  late final _$_productStreamAtom = Atom(
    name: 'StockStoreBase._productStream',
    context: context,
  );

  @override
  Stream<List<Product>> get _productStream {
    _$_productStreamAtom.reportRead();
    return super._productStream;
  }

  bool __productStreamIsInitialized = false;

  @override
  set _productStream(Stream<List<Product>> value) {
    _$_productStreamAtom.reportWrite(
      value,
      __productStreamIsInitialized ? super._productStream : null,
      () {
        super._productStream = value;
        __productStreamIsInitialized = true;
      },
    );
  }

  late final _$productListAtom = Atom(
    name: 'StockStoreBase.productList',
    context: context,
  );

  @override
  ObservableList<Product> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(ObservableList<Product> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  late final _$addToStockAsyncAction = AsyncAction(
    'StockStoreBase.addToStock',
    context: context,
  );

  @override
  Future<Product?> addToStock({required StockFormData product}) {
    return _$addToStockAsyncAction.run(
      () => super.addToStock(product: product),
    );
  }

  late final _$StockStoreBaseActionController = ActionController(
    name: 'StockStoreBase',
    context: context,
  );

  @override
  void _initProductListener() {
    final _$actionInfo = _$StockStoreBaseActionController.startAction(
      name: 'StockStoreBase._initProductListener',
    );
    try {
      return super._initProductListener();
    } finally {
      _$StockStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productList: ${productList},
products: ${products}
    ''';
  }
}
