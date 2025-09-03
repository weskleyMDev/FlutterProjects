part of 'product_repository.dart';

abstract interface class IProductRepository {
  Stream<List<ProductModel>> fetchDataFromFirestore(String category);
}
