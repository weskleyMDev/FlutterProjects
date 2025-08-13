import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/repositories/cart/icart_repository.dart';
import 'package:shop_v2/services/cart/icart_service.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';

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
          _cartItems.clear();
          _cartItems.addAll(data ?? []);
        });
      } else {
        _cartItems.clear();
      }
    });

    final currentUser = GetIt.instance<AuthStore>().currentUser;
    if (currentUser != null) {
      _cartStream = ObservableStream(_cartRepository.cartStream(currentUser));
      _cartStream.listen((data) {
        _cartItems.clear();
        _cartItems.addAll(data ?? []);
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

  @computed
  ObservableList<CartItem> get cartItems => _cartItems;

  @computed
  int get length => _cartItems.length;

  @computed
  int get quantity => _quantity;

  @computed
  StreamStatus get status => _cartStream.status;

  set quantity(int value) => _quantity = value;

  @action
  Future<void> addToCart(
    ProductModel product,
    String category,
    String uid,
    int index,
  ) async {
    await _cartService.addToCart(product, category, uid, index);
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
  void incrementQuantity(CartItem cartItem) {
    _quantity++;
    _cartService.setQuantity(cartItem, _quantity);
  }

  @action
  void decrementQuantity(CartItem cartItem) {
    _quantity--;
    _cartService.setQuantity(cartItem, _quantity);
  }
}
