import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import 'product.dart';

class ProductsList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

// bool _showFavorites = false;

//   List<Product> get items {
//     if (_showFavorites) {
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavorites() {
//         _showFavorites = true;
//         notifyListeners();
//       }

//   void showAll() {
//         _showFavorites = false;
//         notifyListeners();
//       }