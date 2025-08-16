import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/repositories/cart/icart_repository.dart';
import 'package:shop_v2/repositories/coupon/icoupon_repository.dart';
import 'package:shop_v2/services/cart/icart_service.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/products/products.store.dart';
import 'package:shop_v2/utils/binary_search.dart';

part 'cart.store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  CartStoreBase({
    required ICartRepository cartRepository,
    required ICartService cartService,
    required ICouponRepository couponRepository,
  }) : _cartRepository = cartRepository,
       _cartService = cartService,
       _couponRepository = couponRepository,
       _authStore = GetIt.instance<AuthStore>() {
    _authStore.userChanges.listen((user) {
      if (user != null) {
        _cartStream = ObservableStream(_cartRepository.cartStream(user));
        _cartStream.listen((data) {
          final products = GetIt.instance<ProductsStore>().productsList;
          if (products.isEmpty) return;
          products.sort((a, b) => a.id.compareTo(b.id));
          _cartItems.clear();
          for (CartItem item in data) {
            final index = customBinarySearch<ProductModel, CartItem>(
              products,
              item,
              (a, b) => a.id.compareTo(b.productId),
            );
            if (index < 0 || index >= products.length) {
              continue;
            }
            final product = products[index];
            _cartItems.add(item.copyWith(product: product));
          }
          calcCartValues();
        });
      } else {
        _cartItems.clear();
      }
    });

    final currentUser = _authStore.currentUser;
    if (currentUser != null) {
      _cartStream = ObservableStream(_cartRepository.cartStream(currentUser));
      _cartStream.listen((data) {
        final products = GetIt.instance<ProductsStore>().productsList;
        if (products.isEmpty) return;
        products.sort((a, b) => a.id.compareTo(b.id));
        _cartItems.clear();
        for (CartItem item in data) {
          final index = customBinarySearch<ProductModel, CartItem>(
            products,
            item,
            (a, b) => a.id.compareTo(b.productId),
          );
          if (index < 0 || index >= products.length) {
            continue;
          }
          final product = products[index];
          _cartItems.add(item.copyWith(product: product));
        }
        calcCartValues();
      });
    }
  }

  final ICartRepository _cartRepository;
  final ICartService _cartService;
  final ICouponRepository _couponRepository;
  final AuthStore _authStore;

  @observable
  ObservableStream<List<CartItem>> _cartStream = ObservableStream(
    Stream.empty(),
  );

  @observable
  ObservableList<CartItem> _cartItems = ObservableList<CartItem>();

  @observable
  int _quantity = 0;

  @observable
  double _subtotal = 0.0;

  @observable
  double _total = 0.0;

  @observable
  double _discount = 0.0;

  @observable
  double _shipping = 0.0;

  @observable
  int _percent = 0;

  @observable
  bool isLoading = false;

  /*==============================COMPUTED===================================*/

  @computed
  ObservableList<CartItem> get cartItems => _cartItems;

  @computed
  int get length => _cartItems.length;

  @computed
  int get quantity => _quantity;

  @computed
  double get subtotal => _subtotal;

  @computed
  double get total => _total;

  @computed
  double get discount => _discount;

  @computed
  double get shipping => _shipping;

  @computed
  int get percent => _percent;

  @computed
  ObservableStream<List<CartItem>> get cartStream => _cartStream;

  @computed
  StreamStatus get status => _cartStream.status;

  /*==============================ACTION===================================*/

  @action
  Future<void> getCoupon(String coupon) async {
    final doc = await _couponRepository.getCoupon(coupon);
    _percent = doc?['value'];
  }

  @action
  Future<void> addToCart(
    ProductModel product,
    int index,
    String category,
  ) async {
    final currentUser = _authStore.currentUser;
    if (currentUser == null) return;
    await _cartService.addToCart(product, currentUser.id!, index, category);
  }

  @action
  Future<void> removeById(String id, String uid) async {
    final index = _cartItems.indexWhere((element) => element.id == id);
    if (index != -1) {
      await _cartService.removeById(id, uid);
    } else {
      return;
    }
  }

  @action
  void calcCartValues() {
    Decimal subtotal = Decimal.zero;
    for (var item in _cartItems) {
      subtotal +=
          item.quantity.toDecimal() *
          Decimal.parse(item.product?.price.toString() ?? '0.0');
    }
    final percent = Decimal.parse((_percent / 100).toString());
    final discount = subtotal * percent;
    final shipping = Decimal.parse(_shipping.toString());
    final total = (subtotal - discount) + shipping;
    _subtotal = subtotal.toDouble();
    _discount = discount.toDouble();
    _total = total.toDouble();
  }

  @action
  Future<void> incrementQuantity(CartItem cartItem) async {
    _quantity = cartItem.quantity + 1;
    await _cartService.setQuantity(cartItem, _quantity);
    calcCartValues();
  }

  @action
  Future<void> decrementQuantity(CartItem cartItem) async {
    _quantity = cartItem.quantity - 1;
    await _cartService.setQuantity(cartItem, _quantity);
    calcCartValues();
  }

  @action
  Future<void> clearCart() async {
    final currentUser = _authStore.currentUser;
    if (currentUser == null) return;
    await _cartService.clearCart(currentUser.id!);
    _cartItems.clear();
    resetCart();
  }

  @action
  void resetCart() {
    _quantity = 0;
    _subtotal = 0.0;
    _total = 0.0;
    _discount = 0.0;
    _shipping = 0.0;
    _percent = 0;
  }
}
