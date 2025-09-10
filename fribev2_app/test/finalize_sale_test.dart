import 'package:flutter_test/flutter_test.dart';
import 'package:fribev2_app/models/cart_item.dart';
import 'package:fribev2_app/models/product.dart';
import 'package:fribev2_app/models/sales_receipt.dart';
import 'package:fribev2_app/services/receipt_to_pdf.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/payment.store.dart';
import 'package:fribev2_app/stores/sales.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:mocktail/mocktail.dart';

class MockStockStore extends Mock implements StockStore {}

class MockCartStore extends Mock implements CartStore {}

class MockPaymentStore extends Mock implements PaymentStore {}

class MockSalesStore extends Mock implements SalesStore {}

class MockReceiptGenerator extends Mock implements ReceiptGenerator {}

Future<bool> finalizeSale({
  required StockStore stockStore,
  required CartStore cartStore,
  required PaymentStore paymentStore,
  required SalesStore salesStore,
  required ReceiptGenerator receiptGenerator,
}) async {
  final cartList = cartStore.cartList;
  for (final cartItem in cartList) {
    final product = await stockStore.getProductById(id: cartItem.productId);
    if (product == null) continue;

    final newQuantity = (double.parse(product.amount) - cartItem.quantity)
        .toString();

    await stockStore.updateQuantityById(id: product.id, quantity: newQuantity);
  }
  final receipt = await salesStore.createReceipt(
    cart: cartStore,
    payments: paymentStore.payments,
  );
  await receiptGenerator.generateReceipt(receipt: receipt);
  return true;
}

void main() {
  test('finalize sale', () async {
    final stockStore = MockStockStore();
    final cartStore = MockCartStore();
    final paymentStore = MockPaymentStore();
    final salesStore = MockSalesStore();
    final receiptGenerator = MockReceiptGenerator();

    final cartItem = CartItem(
      id: '1',
      productId: 'p1',
      quantity: 1,
      subtotal: 1.0,
    );

    final product = Product(
      id: 'p1',
      name: 'Product 1',
      category: 'Category 1',
      measure: 'Measure 1',
      amount: '1',
      price: '1.0',
    );

    final receipt = SalesReceipt(
      id: 'r1',
      total: '1.0',
      cart: [],
      createAt: DateTime.now(),
      payments: [],
      discount: '0.0',
      shipping: '0.0',
    );

    when(() => cartStore.cartList).thenReturn([cartItem]);
    when(
      () => stockStore.getProductById(id: 'p1'),
    ).thenAnswer((_) async => product);
    when(
      () => stockStore.updateQuantityById(
        id: any(named: 'id'),
        quantity: any(named: 'quantity'),
      ),
    ).thenAnswer((_) async {});
    when(() => paymentStore.payments).thenReturn([]);
    when(
      () => salesStore.createReceipt(cart: cartStore, payments: []),
    ).thenAnswer((_) async => receipt);
    when(() => receiptGenerator.generateReceipt(receipt: any(named: 'receipt')))
    .thenAnswer((_) async {});

    final result = await finalizeSale(
      stockStore: stockStore,
      cartStore: cartStore,
      paymentStore: paymentStore,
      salesStore: salesStore,
      receiptGenerator: receiptGenerator,
    );

    expect(result, true);
    verify(
      () => stockStore.updateQuantityById(id: 'p1', quantity: '0.0'),
    ).called(1);
    verify(
      () => salesStore.createReceipt(cart: cartStore, payments: []),
    ).called(1);
    verify(
      () => receiptGenerator.generateReceipt(receipt: any(named: 'receipt')),
    ).called(1);
  });
}
