import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../exceptions/http_exception.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final String _token;
  final String _uid;
  final List<Product> _items;
  final url = dotenv.get('base_url', fallback: '');

  ProductList([this._token = '', this._uid = '', this._items = const []]);

  String get token => _token;
  String get uid => _uid;
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> toggleFavorite(Product product) async {
    final oldValue = product.isFavorite;

    product.toggleFavorite();
    notifyListeners();

    final success = await updateProduct(product);

    if (!success) {
      product.isFavorite = oldValue;
      notifyListeners();
    }
  }

  Future<void> toggleUserFavorite(Product product, String uid) async {
    final oldValue = product.isFavorite;

    product.toggleFavorite();

    final success = await _updateUserFavorite(product, uid);

    if (!success) {
      product.isFavorite = oldValue;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> _updateUserFavorite(Product product, String uid) async {
    try {
      int index = _items.indexWhere((p) => p.id == product.id);

      if (index >= 0) {
        final response = await put(
          Uri.https(url, '/user-favorite/$uid/${product.id}.json', {
            'auth': token,
          }),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'isFavorite': product.isFavorite}),
        );

        if (response.statusCode >= 400) {
          return false;
        }
        _items[index].isFavorite = product.isFavorite;
        return true;
      } else {
        throw Exception('Product with id: ${product.id} not found!');
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> loadProducts() async {
    final uri = Uri.https(url, '/products.json', {'auth': token});
    final uriFav = Uri.https(url, '/user-favorite/$uid.json', {'auth': token});
    try {
      final response = await get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      final favResponse = await get(
        uriFav,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.body == 'null') return;
      if (response.statusCode >= 400 || favResponse.statusCode >= 400) {
        throw HttpException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }
      final Map<String, dynamic> favData = favResponse.body == 'null'
          ? {}
          : jsonDecode(favResponse.body);
      final Map<String, dynamic> data = jsonDecode(response.body);
      _items.clear();
      if (data.isEmpty) return;
      data.forEach((id, productData) {
        final isFavorite = favData[id]?['isFavorite'] ?? false;
        final product = Product.fromMap({
          'id': id,
          ...productData,
        }).copyWith(isFavorite: isFavorite);
        _items.add(product);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await post(
        Uri.https(url, '/products.json', {'auth': token}),
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

  Future<bool> updateProduct(Product product) async {
    try {
      int index = _items.indexWhere((p) => p.id == product.id);

      if (index >= 0) {
        final response = await put(
          Uri.https(url, '/products/${product.id}.json', {'auth': token}),
          headers: {'Content-Type': 'application/json'},
          body: product.toJson(),
        );

        if (response.statusCode >= 400) {
          return false;
        }
        _items[index] = product;
        notifyListeners();
        return true;
      } else {
        throw Exception('Product with id: ${product.id} not found!');
      }
    } catch (e) {
      return false;
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
          Uri.https(url, '/products/${product.id}.json', {'auth': token}),
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
