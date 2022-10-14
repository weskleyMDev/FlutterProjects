import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../utils/capitalize.dart';

class CartItems extends StatelessWidget with Capitalize {
  const CartItems(this.cartItem, {super.key});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Text(
      capitalize(cartItem.name),
    );
  }
}
