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

  @observable
  String _quantity = '';

  @observable
  String _subtotal = '';

  @computed
  Map<String, CartItem> get cartList => Map.unmodifiable(_cart);

  @computed
  int get itemsCount => _cart.length;

  @computed
  String get totalAmount => _cart.values
      .fold(
        Decimal.zero,
        (sum, item) =>
            sum + Decimal.parse(item.price) * Decimal.parse(item.quantity),
      )
      .toStringAsFixed(2);

  @action
  void setQuantity(String value) =>
      _quantity = value.trim().replaceAll(',', '.');

  @computed
  Map<String, String> get subtotals => _cart.map((productId, item) {
    final subtotal = (Decimal.parse(item.price) * Decimal.parse(item.quantity));
    return MapEntry(productId, subtotal.toStringAsFixed(2));
  });

  @action
  Future<void> addItem({required Product product}) async {
    final qtt = Decimal.parse(_quantity);
    _subtotal = (Decimal.parse(product.price) * qtt).toStringAsFixed(2);
    if (_cart.containsKey(product.id)) {
      _cart.update(product.id, (existItem) {
        final newQuantity = Decimal.parse(existItem.quantity);
        final newSubtotal = Decimal.parse(existItem.subtotal);
        _quantity = (newQuantity + qtt).toString();
        _subtotal = (newSubtotal + (Decimal.parse(product.price) * qtt))
            .toStringAsFixed(2);
        return existItem.copyWith(
          quantity: _quantity,
          subtotal: _subtotal,
        );
      });
    } else {
      _cart.putIfAbsent(
        product.id,
        () => CartItem(
          id: Uuid().v4(),
          productId: product.id,
          name: product.name,
          quantity: _quantity,
          price: product.price,
          subtotal: _subtotal,
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
