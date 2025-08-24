import 'package:decimal/decimal.dart';
import 'package:fribev2_app/models/cart_item.dart';
import 'package:fribev2_app/models/product.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'cart.store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  @observable
  ObservableList<CartItem> _cartList = ObservableList<CartItem>();

  @observable
  double _total = 0.0;

  @observable
  String? _errorMessage;

  /*==================================COMPUTED================================*/

  @computed
  ObservableList<CartItem> get cartList => _cartList;

  @computed
  double get total => _total;

  @computed
  String? get errorMessage => _errorMessage;

  @computed
  bool Function(Product) get isProductInCart {
    return (product) {
      return _cartList.any((item) => item.productId == product.id);
    };
  }

  /*==================================ACTION==================================*/

  @action
  bool addProduct(Product product, [int quantity = 1]) {
    final index = _cartList.indexWhere((item) => item.productId == product.id);
    final newSubtotal = (quantity.toDecimal() * Decimal.parse(product.price))
        .toDouble();
    if (index == -1) {
      _cartList.add(
        CartItem(
          id: Uuid().v4(),
          productId: product.id,
          product: product,
          quantity: quantity,
          subtotal: newSubtotal,
        ),
      );
    } else {
      _errorMessage = 'Produto já adicionado ao carrinho';
      return false;
    }
    _setTotal();
    return true;
  }

  @action
  void removeProductById(String id) {
    _cartList.removeWhere((item) => item.id == id);
    _setTotal();
  }

  @action
  void _setTotal() {
    Decimal result = Decimal.zero;
    for (var item in _cartList) {
      result += item.quantity.toDecimal() * Decimal.parse(item.product!.price);
    }
    _total = result.toDouble();
  }

  @action
  void incrementQuantity(String productId) {
    final index = _cartList.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      final item = _cartList[index];
      final newQuantity = item.quantity + 1;
      final newSubtotal =
          (newQuantity.toDecimal() * Decimal.parse(item.product!.price))
              .toDouble();

      _cartList[index] = item.copyWith(
        quantity: newQuantity,
        subtotal: newSubtotal,
      );
      _setTotal();
    }
  }

  @action
  void decrementQuantity(String productId) {
    final index = _cartList.indexWhere((item) => item.productId == productId);
    if (index != -1 && _cartList[index].quantity > 1) {
      final item = _cartList[index];
      final newQuantity = item.quantity - 1;
      final newSubtotal =
          (newQuantity.toDecimal() * Decimal.parse(item.product!.price))
              .toDouble();

      _cartList[index] = item.copyWith(
        quantity: newQuantity,
        subtotal: newSubtotal,
      );
      _setTotal();
    }
  }

  @action
  void clearCart() {
    _cartList.clear();
    _total = 0.0;
    print('CLEAR CART CALLED!!');
  }

  @action
  void clearErrorMessage() {
    _errorMessage = null;
  }
}
