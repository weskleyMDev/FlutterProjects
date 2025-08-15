import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/repositories/cart/icart_repository.dart';
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
  }) : _cartRepository = cartRepository,
       _cartService = cartService {
    GetIt.instance<AuthStore>().userChanges.listen((user) {
      if (user != null) {
        _cartStream = ObservableStream(_cartRepository.cartStream(user));
        _cartStream.listen((data) {
          final products = GetIt.instance<ProductsStore>().productsList;
          if (products.isEmpty) return;
          products.sort((a, b) => a.id.compareTo(b.id));
          _cartItems.clear();
          for (CartItem item in data ?? []) {
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
        });
      } else {
        _cartItems.clear();
      }
    });

    final currentUser = GetIt.instance<AuthStore>().currentUser;
    if (currentUser != null) {
      _cartStream = ObservableStream(_cartRepository.cartStream(currentUser));
      _cartStream.listen((data) {
        final products = GetIt.instance<ProductsStore>().productsList;
        if (products.isEmpty) return;
        products.sort((a, b) => a.id.compareTo(b.id));
        _cartItems.clear();
        for (CartItem item in data ?? []) {
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
      });
    }
  }

  final ICartRepository _cartRepository;
  final ICartService _cartService;

  @observable
  ObservableStream<List<CartItem>?> _cartStream = ObservableStream(
    Stream.empty(),
  );

  @observable
  ObservableList<CartItem> _cartItems = ObservableList<CartItem>();

  @observable
  int _quantity = 0;

  @observable
  ObservableMap<String, double> _values = ObservableMap<String, double>();

  @computed
  ObservableList<CartItem> get cartItems => _cartItems;

  @computed
  int get length => _cartItems.length;

  @computed
  int get quantity => _quantity;

  @computed
  StreamStatus get status => _cartStream.status;

  @computed
  ObservableMap<String, double> get values => _values;

  @action
  Future<void> addToCart(ProductModel product, String uid, int index) async {
    await _cartService.addToCart(product, uid, index);
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
    final List<Decimal> subtotal = [];
    for (var item in _cartItems) {
      final res =
          item.quantity.toDecimal() *
          Decimal.parse(item.product?.price ?? '0.0');
      subtotal.add(res);
    }
    _values['subtotal'] = subtotal.isEmpty
        ? 0.0
        : subtotal.reduce((a, b) => a + b).toDouble();

    _values['total'] =
        ((_values['subtotal'] ?? 0.0) - (_values['discount'] ?? 0.0)) +
        (_values['shipping'] ?? 0.0);
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
}
