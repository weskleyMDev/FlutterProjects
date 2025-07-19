import 'dart:async';

import '../../models/form_data/stock_form_data.dart';
import '../../models/product.dart';
import 'stock_service.dart';

class LocalStockService implements IStockService {
  static final List<Product> _products = [
    // Product(
    //   id: '1',
    //   name: 'Product 1',
    //   price: '10.00',
    //   category: 'Boi',
    //   type: 'KG',
    //   stock: '100',
    // ),
    // Product(
    //   id: '2',
    //   name: 'Product 2',
    //   price: '20.00',
    //   category: 'Ave',
    //   type: 'PC',
    //   stock: '50',
    // ),
    // Product(
    //   id: '3',
    //   name: 'Product 3',
    //   price: '30.00',
    //   category: 'Boi',
    //   type: 'UN',
    //   stock: '80',
    // ),
  ];
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
