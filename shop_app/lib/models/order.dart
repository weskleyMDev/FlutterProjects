// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'cart_item.dart';

class Order {
  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });

  final DateTime date;
  final String id;
  final List<CartItem> products;
  final double total;
}
