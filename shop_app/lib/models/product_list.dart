import 'package:flutter/material.dart';
import 'package:shop_app/utils/app_logger.dart';
import 'package:uuid/uuid.dart';

import '../data/dummy_data.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void toggleFavorite(Product product) {
    product.toggleFavorite();
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void saveProduct(Map<String, String> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Uuid().v4(),
      title: data['name'] as String,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
      price: data['price'] as String,
    );

    hasId ? updateProduct(newProduct) : addProduct(newProduct);
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    } else {
      AppLogger.error('Product with id: ${product.id} not found!');
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    } else {
      AppLogger.error('Product with id: ${product.id} not found!');
    }
  }
}
