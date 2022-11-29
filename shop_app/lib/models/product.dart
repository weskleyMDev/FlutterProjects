import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  final String description;
  final String id;
  final String imageUrl;
  bool isFavorite;
  final String name;
  final double price;

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
