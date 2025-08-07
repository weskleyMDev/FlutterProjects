class ProductOff {
  final String id;
  final String imageUrl;
  final int pos;
  final int x;
  final int y;

  const ProductOff({
    required this.id,
    required this.imageUrl,
    required this.pos,
    required this.x,
    required this.y,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductOff &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          pos == other.pos &&
          x == other.x &&
          y == other.y);

  @override
  int get hashCode =>
      id.hashCode ^ imageUrl.hashCode ^ pos.hashCode ^ x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'Product{id: $id, imageUrl: $imageUrl, pos: $pos, x: $x, y: $y}';
  }

  ProductOff copyWith({String? id, String? imageUrl, int? pos, int? x, int? y}) {
    return ProductOff(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      pos: pos ?? this.pos,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'imageUrl': imageUrl, 'pos': pos, 'x': x, 'y': y};
  }

  factory ProductOff.fromMap(Map<String, dynamic> map) {
    return ProductOff(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      pos: map['pos'] as int,
      x: map['x'] as int,
      y: map['y'] as int,
    );
  }
}
