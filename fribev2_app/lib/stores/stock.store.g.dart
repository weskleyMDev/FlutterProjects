// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockStore on StockStoreBase, Store {
  Computed<Stream<List<Product>>>? _$productsListComputed;

  @override
  Stream<List<Product>> get productsList =>
      (_$productsListComputed ??= Computed<Stream<List<Product>>>(
        () => super.productsList,
        name: 'StockStoreBase.productsList',
      )).value;
  Computed<Future<void>>? _$filterListComputed;

  @override
  Future<void> get filterList =>
      (_$filterListComputed ??= Computed<Future<void>>(
        () => super.filterList,
        name: 'StockStoreBase.filterList',
      )).value;

  late final _$searchQueryAtom = Atom(
    name: 'StockStoreBase.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$currentCategoryAtom = Atom(
    name: 'StockStoreBase.currentCategory',
    context: context,
  );

  @override
  String get currentCategory {
    _$currentCategoryAtom.reportRead();
    return super.currentCategory;
  }

  @override
  set currentCategory(String value) {
    _$currentCategoryAtom.reportWrite(value, super.currentCategory, () {
      super.currentCategory = value;
    });
  }

  late final _$_productsAtom = Atom(
    name: 'StockStoreBase._products',
    context: context,
  );

  @override
  ObservableStream<List<Product>> get _products {
    _$_productsAtom.reportRead();
    return super._products;
  }

  @override
  set _products(ObservableStream<List<Product>> value) {
    _$_productsAtom.reportWrite(value, super._products, () {
      super._products = value;
    });
  }

  late final _$fetchDataAsyncAction = AsyncAction(
    'StockStoreBase.fetchData',
    context: context,
  );

  @override
  Future<void> fetchData({String? category, String? query}) {
    return _$fetchDataAsyncAction.run(
      () => super.fetchData(category: category, query: query),
    );
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

  late final _$removeProductByIdAsyncAction = AsyncAction(
    'StockStoreBase.removeProductById',
    context: context,
  );

  @override
  Future<void> removeProductById({required Product product}) {
    return _$removeProductByIdAsyncAction.run(
      () => super.removeProductById(product: product),
    );
  }

  late final _$updateProductAsyncAction = AsyncAction(
    'StockStoreBase.updateProduct',
    context: context,
  );

  @override
  Future<void> updateProduct({
    required Product product,
    required StockFormData data,
  }) {
    return _$updateProductAsyncAction.run(
      () => super.updateProduct(product: product, data: data),
    );
  }

  late final _$removeAllByCategoryAsyncAction = AsyncAction(
    'StockStoreBase.removeAllByCategory',
    context: context,
  );

  @override
  Future<void> removeAllByCategory({required String category}) {
    return _$removeAllByCategoryAsyncAction.run(
      () => super.removeAllByCategory(category: category),
    );
  }

  late final _$StockStoreBaseActionController = ActionController(
    name: 'StockStoreBase',
    context: context,
  );

  @override
  void setCategory(String category) {
    final _$actionInfo = _$StockStoreBaseActionController.startAction(
      name: 'StockStoreBase.setCategory',
    );
    try {
      return super.setCategory(category);
    } finally {
      _$StockStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$StockStoreBaseActionController.startAction(
      name: 'StockStoreBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$StockStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchQuery: ${searchQuery},
currentCategory: ${currentCategory},
productsList: ${productsList},
filterList: ${filterList}
    ''';
  }
}
