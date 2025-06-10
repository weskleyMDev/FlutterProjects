import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../utils/app_logger.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void toggleFavorite(Product product) {
    product.toggleFavorite();
    notifyListeners();
  }

  Future<void> loadProducts() async {
    try {
      final urlString = dotenv.get('firebase_url', fallback: '');
      final url = Uri.parse(urlString);
      final response = await get(
        url.replace(path: 'products.json'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode >= 400) {
        throw Exception(
          'Code: ${response.statusCode} - Error: ${response.body}',
        );
      }
      final Map<String, dynamic> data = jsonDecode(response.body);
      _items.clear();
      if (data.isEmpty) {
        return;
      }
      data.forEach((id, productData) {
        final product = Product.fromMap({'id': id, ...productData});
        _items.add(product);
      });
      notifyListeners();
    } catch (e) {
      AppLogger.error('$e');
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final urlString = dotenv.get('firebase_url', fallback: '');
      final url = Uri.parse(urlString);
      final response = await post(
        url.replace(path: 'products.json'),
        headers: {'Content-Type': 'application/json'},
        body: product.toJson(),
      );

      if (response.statusCode >= 400) {
        throw Exception(
          'Code: ${response.statusCode} - Error: ${response.body}',
        );
      }

      final responseData = jsonDecode(response.body);
      final firebaseId = responseData['name'];

      final newProduct = product.copyWith(id: firebaseId);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      AppLogger.error('$e');
      rethrow;
    }
  }

  Future<void> saveProduct(Map<String, String> data) {
    final id = data['id'];
    final title = data['title'] ?? '';
    final description = data['description'] ?? '';
    final imageUrl = data['imageUrl'] ?? '';
    final price = data['price'] ?? '0.0';

    final product = Product(
      id: id ?? '',
      title: title,
      description: description,
      imageUrl: imageUrl,
      price: price,
    );

    final bool hasId = id != null && id.trim().isNotEmpty;
    return hasId ? updateProduct(product) : addProduct(product);
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    } else {
      AppLogger.error('Product with id: ${product.id} not found!');
    }
    return Future.value();
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
