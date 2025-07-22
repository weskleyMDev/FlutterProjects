import 'dart:async';

import '../../models/form_data/stock_form_data.dart';
import '../../models/product.dart';
import 'istock_service.dart';

class LocalStockService implements IStockService {
  static final List<Product> _products = [];
  static MultiStreamController<List<Product>>? _controller;
  static final _productStream = Stream<List<Product>>.multi((controller) {
    _controller = controller;
    controller.add(_products);
  });

  @override
  Stream<List<Product>> getProducts() => _productStream;

  @override
  Future<Product> saveProduct({required StockFormData product}) async {
    final Product newProduct = Product(
      name: product.name,
      category: product.category,
      measure: product.measure,
      amount: product.amount,
      price: product.price,
    );
    _products.add(newProduct);
    _controller?.add(_products);
    return newProduct;
  }

  @override
  Future<void> clearByCategory({required String category}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProductById({required Product product}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProductById({
    required Product product,
    required StockFormData data,
  }) {
    throw UnimplementedError();
  }
}
