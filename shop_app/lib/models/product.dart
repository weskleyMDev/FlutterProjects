// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  final String description;
  final String id;
  final String imageUrl;
  bool isFavorite;
  final double price;
  final String title;

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
