import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cartBloc});

  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final amount = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: 3,
    );
    final currency = NumberFormat.simpleCurrency(locale: locale);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItems = state.cartItems;
        if (cartItems.isEmpty) {
          return const Center(child: Text('Carrinho vazio'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return ListTile(
                      title: Text('Produto ID: ${item.productId}'),
                      subtitle: Text(
                        'Quantidade: ${amount.format(item.quantity)} - Subtotal: ${currency.format(item.subtotal)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          cartBloc.add(RemoveItemFromCart(item.productId));
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    print(state.cartItems);
                  },
                  child: const Text('Finalizar Venda'),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
