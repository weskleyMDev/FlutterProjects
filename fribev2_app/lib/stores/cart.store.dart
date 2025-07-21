import 'package:decimal/decimal.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

part 'cart.store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  @observable
  ObservableMap<String, CartItem> _cart = ObservableMap();

  @computed
  Map<String, CartItem> get cartList => Map.unmodifiable(_cart);

  @computed
  int get itemsCount => _cart.length;

  @computed
  double get totalAmount => _cart.values
      .fold(
        Decimal.zero,
        (sum, item) =>
            sum +
            Decimal.parse(item.price.toStringAsFixed(2)) *
                Decimal.parse(item.quantity.toStringAsFixed(3)),
      )
      .toDouble();

  @computed
  Map<String, double> get subtotals => _cart.map((productId, item) {
    final subtotal =
        (Decimal.parse(item.price.toString()) *
                Decimal.parse(item.quantity.toString()))
            .toDouble();
    return MapEntry(productId, subtotal);
  });

  @action
  void addItem({required Product product}) {
    if (_cart.containsKey(product.id)) {
      _cart.update(product.id, (existItem) {
        final String quantity = existItem.quantity.toString();
        final double newQuantity = (Decimal.parse(quantity) + Decimal.one)
            .toDouble();
        return existItem.copyWith(quantity: newQuantity);
      });
    } else {
      _cart.putIfAbsent(
        product.id,
        () => CartItem(
          id: Uuid().v4(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: double.parse(product.price),
        ),
      );
    }
  }

  @action
  void removeItem({required String productId}) => _cart.remove(productId);

  @action
  void clear() {
    if (_cart.isEmpty) return;
    _cart.clear();
  }
}
