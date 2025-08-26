import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fribev2_app/models/cart_item.dart';
import 'package:fribev2_app/models/cart_product.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../models/payment.dart';
import '../models/sales_receipt.dart';
import '../services/sales/isales_service.dart';
import 'cart.store.dart';

part 'sales.store.g.dart';

class SalesStore = SalesStoreBase with _$SalesStore;

abstract class SalesStoreBase with Store {
  SalesStoreBase(this._salesService);
  final ISalesService _salesService;
  StreamSubscription? _subscription;

  /*===============================OBSERVABLE=================================*/

  @observable
  ObservableStream<List<SalesReceipt>> _receiptStream = ObservableStream(
    Stream<List<SalesReceipt>>.empty(),
  );

  @observable
  ObservableList<SalesReceipt> _receipts = ObservableList<SalesReceipt>();

  @observable
  ObservableMap<String, List<CartProduct>> _receiptProducts =
      ObservableMap<String, List<CartProduct>>();

  /*================================COMPUTED==================================*/

  @computed
  List<SalesReceipt> get receipts => List.unmodifiable(_receipts);

  @computed
  StreamStatus get receiptStreamStatus => _receiptStream.status;

  @computed
  Map<String, List<CartProduct>> get receiptProducts =>
      Map.unmodifiable(_receiptProducts);

  /*=================================ACTION===================================*/

  @action
  Future<void> fetchReceipts() async {
    await _subscription?.cancel();
    _receiptStream = ObservableStream(_salesService.getReceipts());
    _subscription = _receiptStream.listen((receipts) {
      _receipts
        ..clear()
        ..addAll(receipts);
    });
  }

  @action
  Future<void> fetchProductForReceipt(
    BuildContext context,
    List<CartItem> cart,
    String receiptId,
  ) async {
    final stockStore = context.read<StockStore>();
    final cartProducts = await Future.wait(
      cart.map((e) async {
        final product = await stockStore.getProductById(id: e.productId);
        if (product != null) {
          return CartProduct(
            product: product,
            quantity: e.quantity,
            subtotal: e.subtotal,
          );
        } else {
          return null;
        }
      }),
    );
    _receiptProducts[receiptId] = cartProducts
        .whereType<CartProduct>()
        .toList();
  }

  @action
  Future<SalesReceipt> createReceipt({
    required CartStore cart,
    required List<Payment> payments,
  }) async {
    final receipt = await _salesService.createReceipt(
      cart: cart,
      payments: payments,
    );
    return receipt;
  }

  @action
  Future<void> deleteReceiptById({required SalesReceipt receipt}) async {
    await _salesService.deleteReceiptById(receipt: receipt);
  }

  @action
  Future<void> clearSaleStore() async {
    await _subscription?.cancel();
    _receiptProducts.clear();
    _receipts.clear();
    print('CLEAR SALE STORE CALLED!!');
  }
}
