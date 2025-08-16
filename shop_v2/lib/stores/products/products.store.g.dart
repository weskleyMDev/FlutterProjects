// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on ProductsStoreBase, Store {
  Computed<String?>? _$categoryIdComputed;

  @override
  String? get categoryId => (_$categoryIdComputed ??= Computed<String?>(
    () => super.categoryId,
    name: 'ProductsStoreBase.categoryId',
  )).value;
  Computed<ObservableList<ProductModel>>? _$productsListComputed;

  @override
  ObservableList<ProductModel> get productsList =>
      (_$productsListComputed ??= Computed<ObservableList<ProductModel>>(
        () => super.productsList,
        name: 'ProductsStoreBase.productsList',
      )).value;
  Computed<String?>? _$categoryLabelComputed;

  @override
  String? get categoryLabel => (_$categoryLabelComputed ??= Computed<String?>(
    () => super.categoryLabel,
    name: 'ProductsStoreBase.categoryLabel',
  )).value;
  Computed<int?>? _$selectedSizeComputed;

  @override
  int? get selectedSize => (_$selectedSizeComputed ??= Computed<int?>(
    () => super.selectedSize,
    name: 'ProductsStoreBase.selectedSize',
  )).value;
  Computed<StreamStatus>? _$statusComputed;

  @override
  StreamStatus get status => (_$statusComputed ??= Computed<StreamStatus>(
    () => super.status,
    name: 'ProductsStoreBase.status',
  )).value;

  late final _$_categoryLabelAtom = Atom(
    name: 'ProductsStoreBase._categoryLabel',
    context: context,
  );

  @override
  String? get _categoryLabel {
    _$_categoryLabelAtom.reportRead();
    return super._categoryLabel;
  }

  @override
  set _categoryLabel(String? value) {
    _$_categoryLabelAtom.reportWrite(value, super._categoryLabel, () {
      super._categoryLabel = value;
    });
  }

  late final _$_selectedSizeAtom = Atom(
    name: 'ProductsStoreBase._selectedSize',
    context: context,
  );

  @override
  int? get _selectedSize {
    _$_selectedSizeAtom.reportRead();
    return super._selectedSize;
  }

  @override
  set _selectedSize(int? value) {
    _$_selectedSizeAtom.reportWrite(value, super._selectedSize, () {
      super._selectedSize = value;
    });
  }

  late final _$_productsStreamAtom = Atom(
    name: 'ProductsStoreBase._productsStream',
    context: context,
  );

  @override
  ObservableStream<List<ProductModel>> get _productsStream {
    _$_productsStreamAtom.reportRead();
    return super._productsStream;
  }

  @override
  set _productsStream(ObservableStream<List<ProductModel>> value) {
    _$_productsStreamAtom.reportWrite(value, super._productsStream, () {
      super._productsStream = value;
    });
  }

  late final _$_productsListAtom = Atom(
    name: 'ProductsStoreBase._productsList',
    context: context,
  );

  @override
  ObservableList<ProductModel> get _productsList {
    _$_productsListAtom.reportRead();
    return super._productsList;
  }

  @override
  set _productsList(ObservableList<ProductModel> value) {
    _$_productsListAtom.reportWrite(value, super._productsList, () {
      super._productsList = value;
    });
  }

  late final _$_categoryIdAtom = Atom(
    name: 'ProductsStoreBase._categoryId',
    context: context,
  );

  @override
  String? get _categoryId {
    _$_categoryIdAtom.reportRead();
    return super._categoryId;
  }

  @override
  set _categoryId(String? value) {
    _$_categoryIdAtom.reportWrite(value, super._categoryId, () {
      super._categoryId = value;
    });
  }

  late final _$toggleCategoryAsyncAction = AsyncAction(
    'ProductsStoreBase.toggleCategory',
    context: context,
  );

  @override
  Future<void> toggleCategory(BuildContext context, CategoriesList options) {
    return _$toggleCategoryAsyncAction.run(
      () => super.toggleCategory(context, options),
    );
  }

  late final _$getProductsByIdAsyncAction = AsyncAction(
    'ProductsStoreBase.getProductsById',
    context: context,
  );

  @override
  Future<ProductModel?> getProductsById(String category, String id) {
    return _$getProductsByIdAsyncAction.run(
      () => super.getProductsById(category, id),
    );
  }

  late final _$ProductsStoreBaseActionController = ActionController(
    name: 'ProductsStoreBase',
    context: context,
  );

  @override
  void dispose() {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
      name: 'ProductsStoreBase.dispose',
    );
    try {
      return super.dispose();
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoryId: ${categoryId},
productsList: ${productsList},
categoryLabel: ${categoryLabel},
selectedSize: ${selectedSize},
status: ${status}
    ''';
  }
}
