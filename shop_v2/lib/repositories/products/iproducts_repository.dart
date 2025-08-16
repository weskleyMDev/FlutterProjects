import 'package:shop_v2/models/products/product_model.dart';

abstract class IProductsRepository {
  Stream<List<ProductModel>> getProductsByCategory({required String category});
  Future<ProductModel?> getProductById({
    required String category,
    required String id,
  });
}
