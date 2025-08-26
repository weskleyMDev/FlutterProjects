// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SalesStore on SalesStoreBase, Store {
  Computed<List<SalesReceipt>>? _$receiptsComputed;

  @override
  List<SalesReceipt> get receipts =>
      (_$receiptsComputed ??= Computed<List<SalesReceipt>>(
        () => super.receipts,
        name: 'SalesStoreBase.receipts',
      )).value;
  Computed<StreamStatus>? _$receiptStreamStatusComputed;

  @override
  StreamStatus get receiptStreamStatus =>
      (_$receiptStreamStatusComputed ??= Computed<StreamStatus>(
        () => super.receiptStreamStatus,
        name: 'SalesStoreBase.receiptStreamStatus',
      )).value;
  Computed<Map<String, List<CartProduct>>>? _$receiptProductsComputed;

  @override
  Map<String, List<CartProduct>> get receiptProducts =>
      (_$receiptProductsComputed ??= Computed<Map<String, List<CartProduct>>>(
        () => super.receiptProducts,
        name: 'SalesStoreBase.receiptProducts',
      )).value;

  late final _$_receiptStreamAtom = Atom(
    name: 'SalesStoreBase._receiptStream',
    context: context,
  );

  @override
  ObservableStream<List<SalesReceipt>> get _receiptStream {
    _$_receiptStreamAtom.reportRead();
    return super._receiptStream;
  }

  @override
  set _receiptStream(ObservableStream<List<SalesReceipt>> value) {
    _$_receiptStreamAtom.reportWrite(value, super._receiptStream, () {
      super._receiptStream = value;
    });
  }

  late final _$_receiptsAtom = Atom(
    name: 'SalesStoreBase._receipts',
    context: context,
  );

  @override
  ObservableList<SalesReceipt> get _receipts {
    _$_receiptsAtom.reportRead();
    return super._receipts;
  }

  @override
  set _receipts(ObservableList<SalesReceipt> value) {
    _$_receiptsAtom.reportWrite(value, super._receipts, () {
      super._receipts = value;
    });
  }

  late final _$_receiptProductsAtom = Atom(
    name: 'SalesStoreBase._receiptProducts',
    context: context,
  );

  @override
  ObservableMap<String, List<CartProduct>> get _receiptProducts {
    _$_receiptProductsAtom.reportRead();
    return super._receiptProducts;
  }

  @override
  set _receiptProducts(ObservableMap<String, List<CartProduct>> value) {
    _$_receiptProductsAtom.reportWrite(value, super._receiptProducts, () {
      super._receiptProducts = value;
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

  late final _$fetchProductForReceiptAsyncAction = AsyncAction(
    'SalesStoreBase.fetchProductForReceipt',
    context: context,
  );

  @override
  Future<void> fetchProductForReceipt(
    BuildContext context,
    List<CartItem> cart,
    String receiptId,
  ) {
    return _$fetchProductForReceiptAsyncAction.run(
      () => super.fetchProductForReceipt(context, cart, receiptId),
    );
  }

  late final _$createReceiptAsyncAction = AsyncAction(
    'SalesStoreBase.createReceipt',
    context: context,
  );

  @override
  Future<SalesReceipt> createReceipt({
    required CartStore cart,
    required List<Payment> payments,
  }) {
    return _$createReceiptAsyncAction.run(
      () => super.createReceipt(cart: cart, payments: payments),
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

  late final _$clearSaleStoreAsyncAction = AsyncAction(
    'SalesStoreBase.clearSaleStore',
    context: context,
  );

  @override
  Future<void> clearSaleStore() {
    return _$clearSaleStoreAsyncAction.run(() => super.clearSaleStore());
  }

  @override
  String toString() {
    return '''
receipts: ${receipts},
receiptStreamStatus: ${receiptStreamStatus},
receiptProducts: ${receiptProducts}
    ''';
  }
}
