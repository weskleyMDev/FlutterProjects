// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SalesStore on SalesStoreBase, Store {
  Computed<Stream<List<SalesReceipt>>>? _$allReceiptsComputed;

  @override
  Stream<List<SalesReceipt>> get allReceipts =>
      (_$allReceiptsComputed ??= Computed<Stream<List<SalesReceipt>>>(
        () => super.allReceipts,
        name: 'SalesStoreBase.allReceipts',
      )).value;

  late final _$_receiptsAtom = Atom(
    name: 'SalesStoreBase._receipts',
    context: context,
  );

  @override
  ObservableStream<List<SalesReceipt>> get _receipts {
    _$_receiptsAtom.reportRead();
    return super._receipts;
  }

  @override
  set _receipts(ObservableStream<List<SalesReceipt>> value) {
    _$_receiptsAtom.reportWrite(value, super._receipts, () {
      super._receipts = value;
    });
  }

  late final _$fetchReceiptsAsyncAction = AsyncAction(
    'SalesStoreBase.fetchReceipts',
    context: context,
  );

  @override
  Future<void> fetchReceipts() {
    return _$fetchReceiptsAsyncAction.run(() => super.fetchReceipts());
  }

  late final _$createReceiptAsyncAction = AsyncAction(
    'SalesStoreBase.createReceipt',
    context: context,
  );

  @override
  Future<SalesReceipt?> createReceipt({required CartStore cart}) {
    return _$createReceiptAsyncAction.run(
      () => super.createReceipt(cart: cart),
    );
  }

  late final _$deleteReceiptByIdAsyncAction = AsyncAction(
    'SalesStoreBase.deleteReceiptById',
    context: context,
  );

  @override
  Future<void> deleteReceiptById({required SalesReceipt receipt}) {
    return _$deleteReceiptByIdAsyncAction.run(
      () => super.deleteReceiptById(receipt: receipt),
    );
  }

  @override
  String toString() {
    return '''
allReceipts: ${allReceipts}
    ''';
  }
}
