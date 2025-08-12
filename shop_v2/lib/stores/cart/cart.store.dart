import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/repositories/cart/icart_repository.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';

part 'cart.store.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  CartStoreBase({required ICartRepository cartRepository})
    : _cartRepository = cartRepository {
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
  void incrementQuantity() {
    _quantity++;
  }

  @action
  void decrementQuantity() {
    _quantity--;
  }
}
