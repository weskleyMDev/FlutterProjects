import 'package:admin_fribe/models/product_sales.dart';
import 'package:equatable/equatable.dart';

final class WeekProductSales extends Equatable {
  final String id;
  final List<ProductSales> productSales;

  const WeekProductSales._({required this.id, required this.productSales});

  factory WeekProductSales.empty() =>
      const WeekProductSales._(id: '', productSales: []);

  WeekProductSales copyWith({String? id, List<ProductSales>? productSales}) =>
      WeekProductSales._(
        id: id ?? this.id,
        productSales: productSales ?? this.productSales,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, productSales];
}
