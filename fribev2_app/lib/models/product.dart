class Product {
  final String id;
  final String name;
  final String category;
  final String type;
  final String stock;
  final String price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.stock,
    required this.price,
    this.imageUrl,
  });
}
