// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockStore on StockStoreBase, Store {
  Computed<List<Product>>? _$productListComputed;

  @override
  List<Product> get productList =>
      (_$productListComputed ??= Computed<List<Product>>(
        () => super.productList,
        name: 'StockStoreBase.productList',
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

  late final _$_productListAtom = Atom(
    name: 'StockStoreBase._productList',
    context: context,
  );

  @override
  ObservableList<Product> get _productList {
    _$_productListAtom.reportRead();
    return super._productList;
  }

  @override
  set _productList(ObservableList<Product> value) {
    _$_productListAtom.reportWrite(value, super._productList, () {
      super._productList = value;
    });
  }

  late final _$allProductsAtom = Atom(
    name: 'StockStoreBase.allProducts',
    context: context,
  );

  @override
  List<Product> get allProducts {
    _$allProductsAtom.reportRead();
    return super.allProducts;
  }

  @override
  set allProducts(List<Product> value) {
    _$allProductsAtom.reportWrite(value, super.allProducts, () {
      super.allProducts = value;
    });
  }

  late final _$preloadProductsAsyncAction = AsyncAction(
    'StockStoreBase.preloadProducts',
    context: context,
  );

  @override
  Future<void> preloadProducts() {
    return _$preloadProductsAsyncAction.run(() => super.preloadProducts());
  }

  late final _$loadProductByCategoryAsyncAction = AsyncAction(
    'StockStoreBase.loadProductByCategory',
    context: context,
  );

  @override
  Future<void> loadProductByCategory() {
    return _$loadProductByCategoryAsyncAction.run(
      () => super.loadProductByCategory(),
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
allProducts: ${allProducts},
productList: ${productList}
    ''';
  }
}
