import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:fribev2_app/models/cart_item.dart';
import 'package:fribev2_app/models/product.dart';
import 'package:fribev2_app/stores/payment.store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

part 'cart.store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  @observable
  ObservableList<CartItem> _cartList = ObservableList<CartItem>();

  @observable
  double _total = 0.0;

  @observable
  String _discount = '0.0';

  @observable
  String _shipping = '0.0';

  @observable
  String quantity = '0';

  @observable
  Decimal _remaining = Decimal.zero;

  @observable
  String? _errorMessage;

  /*==================================COMPUTED================================*/

  @computed
  List<CartItem> get cartList => _cartList;

  @computed
  double get total => _total;

  @computed
  String get discount => _discount;

  @computed
  String get shipping => _shipping;

  @computed
  double get remaining => _remaining.toDouble();

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
  bool addProduct(BuildContext context, Product product) {
    final index = _cartList.indexWhere((item) => item.productId == product.id);
    final newSubtotal = (Decimal.parse(quantity) * Decimal.parse(product.price))
        .round(scale: 2)
        .toDouble();
    if (index == -1) {
      _cartList.add(
        CartItem(
          id: Uuid().v4(),
          productId: product.id,
          product: product,
          quantity: double.parse(quantity),
          subtotal: newSubtotal,
        ),
      );
    } else {
      _errorMessage = 'Produto já adicionado ao carrinho';
      return false;
    }
    _setTotal();
    setRemaining(context);
    return true;
  }

  @action
  void setRemaining(BuildContext context) {
    final totalPayment = context.read<PaymentStore>().totalPayments;
    _remaining =
        (Decimal.parse(total.toString())) -
        Decimal.parse(totalPayment.toString()).round(scale: 2);
  }

  @action
  void removeProductById(BuildContext context, String id) {
    _cartList.removeWhere((item) => item.id == id);
    _setTotal();
    _remaining = Decimal.parse(_total.toString());
  }

  @action
  void _setTotal() {
    Decimal result = Decimal.zero;
    for (var item in _cartList) {
      result +=
          Decimal.parse(item.quantity.toString()) *
          Decimal.parse(item.product!.price);
    }
    _total = (result - Decimal.parse(_discount) + Decimal.parse(_shipping))
        .round(scale: 2)
        .toDouble();
  }

  @action
  void setDiscount(String value) {
    _discount = value;
    _setTotal();
    _remaining = Decimal.parse(_total.toString());
  }

  @action
  void setShipping(String value) {
    _shipping = value;
    _setTotal();
    _remaining = Decimal.parse(_total.toString());
  }

  @action
  Future<bool> updateQuantity(BuildContext context, String cid) async {
    final index = _cartList.indexWhere((item) => item.id == cid);
    if (index != -1) {
      final item = _cartList[index];
      final newSubtotal =
          (Decimal.parse(quantity) * Decimal.parse(item.product!.price))
              .round(scale: 2)
              .toDouble();
      _cartList[index] = item.copyWith(
        quantity: double.parse(quantity),
        subtotal: newSubtotal,
      );
      _setTotal();
      _remaining = Decimal.parse(_total.toString());
      return true;
    } else {
      return false;
    }
  }

  @action
  void incrementQuantity(String productId) {
    final index = _cartList.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      final item = _cartList[index];
      final newQuantity = item.quantity + 1;
      final newSubtotal =
          (Decimal.parse(newQuantity.toString()) *
                  Decimal.parse(item.product!.price))
              .round(scale: 2)
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
          (Decimal.parse(newQuantity.toString()) *
                  Decimal.parse(item.product!.price))
              .round(scale: 2)
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
    quantity = '0';
  }

  @action
  void clearErrorMessage() {
    _errorMessage = null;
  }

  @action
  void clearCartStore() {
    clearCart();
    clearErrorMessage();
    print('DISPOSE CART STORE!!');
  }
}
