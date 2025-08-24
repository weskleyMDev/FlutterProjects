// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockStore on StockStoreBase, Store {
  Computed<StreamStatus>? _$productStreamStatusComputed;

  @override
  StreamStatus get productStreamStatus =>
      (_$productStreamStatusComputed ??= Computed<StreamStatus>(
        () => super.productStreamStatus,
        name: 'StockStoreBase.productStreamStatus',
      )).value;
  Computed<List<Product>>? _$filteredProductsComputed;

  @override
  List<Product> get filteredProducts =>
      (_$filteredProductsComputed ??= Computed<List<Product>>(
        () => super.filteredProducts,
        name: 'StockStoreBase.filteredProducts',
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
  String? get currentCategory {
    _$currentCategoryAtom.reportRead();
    return super.currentCategory;
  }

  @override
  set currentCategory(String? value) {
    _$currentCategoryAtom.reportWrite(value, super.currentCategory, () {
      super.currentCategory = value;
    });
  }

  late final _$_productStreamAtom = Atom(
    name: 'StockStoreBase._productStream',
    context: context,
  );

  @override
  ObservableStream<List<Product>> get _productStream {
    _$_productStreamAtom.reportRead();
    return super._productStream;
  }

  @override
  set _productStream(ObservableStream<List<Product>> value) {
    _$_productStreamAtom.reportWrite(value, super._productStream, () {
      super._productStream = value;
    });
  }

  late final _$_productsByCategoryAtom = Atom(
    name: 'StockStoreBase._productsByCategory',
    context: context,
  );

  @override
  ObservableList<Product> get _productsByCategory {
    _$_productsByCategoryAtom.reportRead();
    return super._productsByCategory;
  }

  @override
  set _productsByCategory(ObservableList<Product> value) {
    _$_productsByCategoryAtom.reportWrite(value, super._productsByCategory, () {
      super._productsByCategory = value;
    });
  }

  late final _$fetchDataAsyncAction = AsyncAction(
    'StockStoreBase.fetchData',
    context: context,
  );

  @override
  Future<void> fetchData({String? category}) {
    return _$fetchDataAsyncAction.run(
      () => super.fetchData(category: category),
    );
  }

  late final _$getProductByIdAsyncAction = AsyncAction(
    'StockStoreBase.getProductById',
    context: context,
  );

  @override
  Future<Product?> getProductById({required String id}) {
    return _$getProductByIdAsyncAction.run(() => super.getProductById(id: id));
  }

  late final _$addToStockAsyncAction = AsyncAction(
    'StockStoreBase.addToStock',
    context: context,
  );

  @override
  Future<Product?> addToStock({required Product product}) {
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
  Future<void> updateProduct({required Product product}) {
    return _$updateProductAsyncAction.run(
      () => super.updateProduct(product: product),
    );
  }

  late final _$updateQuantityByIdAsyncAction = AsyncAction(
    'StockStoreBase.updateQuantityById',
    context: context,
  );

  @override
  Future<void> updateQuantityById({
    required String id,
    required String quantity,
  }) {
    return _$updateQuantityByIdAsyncAction.run(
      () => super.updateQuantityById(id: id, quantity: quantity),
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

  late final _$disposeStockAsyncAction = AsyncAction(
    'StockStoreBase.disposeStock',
    context: context,
  );

  @override
  Future<void> disposeStock() {
    return _$disposeStockAsyncAction.run(() => super.disposeStock());
  }

  @override
  String toString() {
    return '''
searchQuery: ${searchQuery},
currentCategory: ${currentCategory},
productStreamStatus: ${productStreamStatus},
filteredProducts: ${filteredProducts}
    ''';
  }
}
