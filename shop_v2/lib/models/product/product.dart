// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String imageUrl;
  final int pos;
  final int x;
  final int y;

  Product({
    required this.imageUrl,
    required this.pos,
    required this.x,
    required this.y,
  });

  Product copyWith({String? imageUrl, int? pos, int? x, int? y}) {
    return Product(
      imageUrl: imageUrl ?? this.imageUrl,
      pos: pos ?? this.pos,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'imageUrl': imageUrl, 'pos': pos, 'x': x, 'y': y};
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imageUrl: map['imageUrl'] as String,
      pos: map['pos'] as int,
      x: map['x'] as int,
      y: map['y'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(imageUrl: $imageUrl, pos: $pos, x: $x, y: $y)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.pos == pos &&
        other.x == x &&
        other.y == y;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^ pos.hashCode ^ x.hashCode ^ y.hashCode;
  }
}
