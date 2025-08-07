// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showcase.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShowcaseStore on ShowcaseStoreBase, Store {
  Computed<Stream<List<ProductOff>>>? _$productsListComputed;

  @override
  Stream<List<ProductOff>> get productsList =>
      (_$productsListComputed ??= Computed<Stream<List<ProductOff>>>(
        () => super.productsList,
        name: 'ShowcaseStoreBase.productsList',
      )).value;

  late final _$_productStreamAtom = Atom(
    name: 'ShowcaseStoreBase._productStream',
    context: context,
  );

  @override
  ObservableStream<List<ProductOff>> get _productStream {
    _$_productStreamAtom.reportRead();
    return super._productStream;
  }

  @override
  set _productStream(ObservableStream<List<ProductOff>> value) {
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
