import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  String quantity = '';

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

  @computed
  Map<String, String> get subtotals => _cart.map((productId, item) {
    final subtotal = (Decimal.parse(item.price) * Decimal.parse(item.quantity));
    return MapEntry(productId, subtotal.toStringAsFixed(2));
  });

  @action
  Future<void> addItem({required Product product}) async {
    final qtt = Decimal.parse(quantity);
    if (_cart.containsKey(product.id)) {
      _cart.update(product.id, (existItem) {
        final newQuantity = Decimal.parse(existItem.quantity);
        return existItem.copyWith(quantity: (newQuantity + qtt).toString());
      });
    } else {
      _cart.putIfAbsent(
        product.id,
        () => CartItem(
          id: Uuid().v4(),
          productId: product.id,
          name: product.name,
          quantity: quantity,
          price: product.price,
        ),
      );
    }
  }

  @action
  Future<bool?> showDialogQuantity({required BuildContext context}) async {
    final formKey = GlobalKey<FormState>();
    quantity = '';
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Digite a quantidade desejada'),
        content: Form(
          key: formKey,
          child: TextFormField(
            key: ValueKey('quantity'),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Quantidade'),
            ),
            onChanged: (value) => quantity = value.trim().replaceAll(',', '.'),
            validator: (value) {
              final qtt = value?.trim().replaceAll(',', '.') ?? '0';
              if (qtt.isEmpty) return 'Campo obrigatório!';
              final parsedValue = Decimal.tryParse(qtt);
              final validParsedValue =
                  parsedValue == null || parsedValue <= Decimal.zero;
              final numberPattern = RegExp(
                r'^\d+([.,]\d{0,3})?$',
              ).hasMatch(qtt);
              if (!numberPattern || validParsedValue) {
                return 'Digite apenas números positivos (ex: 2.345)';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              quantity = '';
              context.pop(false);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final isValid = formKey.currentState?.validate() ?? false;
              if (!isValid) return;
              context.pop(true);
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @action
  void removeItem({required String productId}) => _cart.remove(productId);

  @action
  void clear() {
    if (_cart.isEmpty) return;
    _cart.clear();
  }
}
