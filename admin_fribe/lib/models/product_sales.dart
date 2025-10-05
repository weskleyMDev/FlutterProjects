import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

final class ProductSales extends Equatable {
  final String productId;
  final Decimal totalSales;

  const ProductSales._({required this.productId, required this.totalSales});

  factory ProductSales.empty() =>
      ProductSales._(productId: '', totalSales: Decimal.zero);

  ProductSales copyWith({String? productId, Decimal? totalSales}) =>
      ProductSales._(
        productId: productId ?? this.productId,
        totalSales: totalSales ?? this.totalSales,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [productId, totalSales];
}
