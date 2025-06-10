import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../exceptions/http_exception.dart';
import '../utils/app_logger.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];
  final url = Uri.parse(dotenv.get('firebase_url', fallback: ''));

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> toggleFavorite(Product product) async {
    try {
      product.toggleFavorite();
      notifyListeners();
      await updateProduct(product.copyWith(isFavorite: product.isFavorite));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadProducts() async {
    try {
      final response = await get(
        url.replace(path: 'products.json'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.body == 'null') return;
      if (response.statusCode >= 400) {
        throw HttpException(
          statusCode: response.statusCode,
          message: response.body,
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
      final response = await post(
        url.replace(path: 'products.json'),
        headers: {'Content-Type': 'application/json'},
        body: product.toJson(),
      );

      if (response.statusCode >= 400) {
        throw HttpException(
          statusCode: response.statusCode,
          message: response.body,
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

  Future<void> updateProduct(Product product) async {
    try {
      int index = _items.indexWhere((p) => p.id == product.id);

      if (index >= 0) {
        await put(
          url.replace(path: 'products/${product.id}.json'),
          headers: {'Content-Type': 'application/json'},
          body: product.toJson(),
        );
        _items[index] = product;
        notifyListeners();
      } else {
        throw Exception('Product with id: ${product.id} not found!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeProduct(Product product) async {
    try {
      int index = _items.indexWhere((p) => p.id == product.id);

      if (index >= 0) {
        final product = _items[index];
        _items.remove(product);
        notifyListeners();
        final response = await delete(
          url.replace(path: 'products/${product.id}.json'),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode >= 400) {
          _items.insert(index, product);
          notifyListeners();
          throw HttpException(
            statusCode: response.statusCode,
            message: response.body,
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
