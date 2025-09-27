import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/models/cart_item_model.dart';
import 'package:seller_fribe/models/product_model.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.cartItems,
    required this.amount,
    required this.currency,
    required this.cartBloc,
  });

  final List<CartItemModel> cartItems;
  final NumberFormat amount;
  final NumberFormat currency;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return BlocSelector<ProductBloc, ProductState, ProductModel>(
          selector: (state) {
            return state.allProducts.firstWhere(
              (product) => product.id == item.productId,
              orElse: () => ProductModel.empty(),
            );
          },
          builder: (context, product) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3.0,
                horizontal: 12.0,
              ),
              child: Chip(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                label: ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                    'Quantidade: ${amount.format(item.quantity)} (${product.measure})\nSubtotal: ${currency.format(item.subtotal)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      cartBloc.add(RemoveItemFromCart(item.productId));
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
