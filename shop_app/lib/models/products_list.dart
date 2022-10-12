import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import 'product.dart';

class ProductsList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  bool _showFavorites = false;

  List<Product> get items {
    if (_showFavorites) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavorites() {
        _showFavorites = true;
        notifyListeners();
      }

  void showAll() {
        _showFavorites = false;
        notifyListeners();
      }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
