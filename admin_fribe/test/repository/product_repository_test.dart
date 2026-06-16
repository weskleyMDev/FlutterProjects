import 'package:admin_fribe/models/update_amount_result.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late ProductRepository repository;

  setUp(() {
    firestore = FakeFirebaseFirestore();

    repository = ProductRepository(firestore: firestore);
  });

  test('should update product amount and return correct result', () async {
    await firestore.collection('stock').doc('product123').set({
      'id': 'product123',
      'amount': '10',
    });

    final result = await repository.updateProductAmount(
      productId: 'product123',
      newAmount: '5',
    );

    expect(
      result,
      const UpdateAmountResult(
        oldAmount: '10',
        addedAmount: '5',
        newAmount: '15',
      ),
    );

    final snapshot = await firestore
        .collection('stock')
        .doc('product123')
        .get();

    expect(snapshot.data()?['amount'], '15');
  });

  test('should throw exception when product does not exist', () async {
    expect(
      () => repository.updateProductAmount(
        productId: 'invalidProduct',
        newAmount: '5',
      ),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Product not found'),
        ),
      ),
    );
  });
}
