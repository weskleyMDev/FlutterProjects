// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockStore on StockStoreBase, Store {
  Computed<Stream<List<Product>>>? _$stockComputed;

  @override
  Stream<List<Product>> get stock =>
      (_$stockComputed ??= Computed<Stream<List<Product>>>(
        () => super.stock,
        name: 'StockStoreBase.stock',
      )).value;

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

  @override
  String toString() {
    return '''
stock: ${stock}
    ''';
  }
}
