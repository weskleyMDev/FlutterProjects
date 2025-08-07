import 'package:shop_v2/models/products/products_off.dart';

abstract class IShowcaseService {
  Stream<List<ProductOff>> get products;
}
