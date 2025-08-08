// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on ProductsStoreBase, Store {
  Computed<Stream<List<ProductModel>>>? _$productsListComputed;

  @override
  Stream<List<ProductModel>> get productsList =>
      (_$productsListComputed ??= Computed<Stream<List<ProductModel>>>(
        () => super.productsList,
        name: 'ProductsStoreBase.productsList',
      )).value;
  Computed<int?>? _$selectedIndexComputed;

  @override
  int? get selectedIndex => (_$selectedIndexComputed ??= Computed<int?>(
    () => super.selectedIndex,
    name: 'ProductsStoreBase.selectedIndex',
  )).value;

  late final _$categoryLabelAtom = Atom(
    name: 'ProductsStoreBase.categoryLabel',
    context: context,
  );

  @override
  String? get categoryLabel {
    _$categoryLabelAtom.reportRead();
    return super.categoryLabel;
  }

  @override
  set categoryLabel(String? value) {
    _$categoryLabelAtom.reportWrite(value, super.categoryLabel, () {
      super.categoryLabel = value;
    });
  }

  late final _$_selectedIndexAtom = Atom(
    name: 'ProductsStoreBase._selectedIndex',
    context: context,
  );

  @override
  int? get _selectedIndex {
    _$_selectedIndexAtom.reportRead();
    return super._selectedIndex;
  }

  @override
  set _selectedIndex(int? value) {
    _$_selectedIndexAtom.reportWrite(value, super._selectedIndex, () {
      super._selectedIndex = value;
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

  @override
  String toString() {
    return '''
categoryLabel: ${categoryLabel},
productsList: ${productsList},
selectedIndex: ${selectedIndex}
    ''';
  }
}
