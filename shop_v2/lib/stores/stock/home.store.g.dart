// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<Stream<List<Product>>>? _$productsListComputed;

  @override
  Stream<List<Product>> get productsList =>
      (_$productsListComputed ??= Computed<Stream<List<Product>>>(
        () => super.productsList,
        name: 'HomeStoreBase.productsList',
      )).value;

  late final _$_productStreamAtom = Atom(
    name: 'HomeStoreBase._productStream',
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

  @override
  String toString() {
    return '''
productsList: ${productsList}
    ''';
  }
}
