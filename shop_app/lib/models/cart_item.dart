// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String id;
  final String name;
  final double price;
  final String productId;
  final int quantity;
}
