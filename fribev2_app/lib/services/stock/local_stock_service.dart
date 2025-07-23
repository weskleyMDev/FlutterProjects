import 'dart:async';

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
  Future<Product> saveProduct({required Product product}) async {
    _products.add(product);
    _controller?.add(_products);
    return product;
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
  Future<void> updateProductById({required Product product}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateQuantityById({required String id, required String quantity}) {
    throw UnimplementedError();
  }
}
