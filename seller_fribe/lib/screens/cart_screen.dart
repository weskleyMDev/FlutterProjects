import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/blocs/cart/validator/discount_input.dart';
import 'package:seller_fribe/widgets/cart_item_tile.dart';

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
        DiscountInput.setTotal(state.subtotal.toDouble());
        if (cartItems.isEmpty) {
          return const Center(child: Text('Carrinho vazio'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CartItemTile(
                cartItems: cartItems,
                amount: amount,
                currency: currency,
                cartBloc: cartBloc,
              ),
              const Divider(thickness: 2.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Desconto',
                    prefixText: '${currency.currencySymbol} ',
                    border: const OutlineInputBorder(),
                    errorText: state.discountError,
                  ),
                  onChanged: (value) {
                    cartBloc.add(
                      CartDiscountChanged(value.trim().replaceAll(',', '.')),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Motivo',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Frete',
                    prefixText: '${currency.currencySymbol} ',
                    border: const OutlineInputBorder(),
                    errorText: state.shippingError,
                  ),
                  onChanged: (value) => cartBloc.add(
                    CartShippingChanged(value.trim().replaceAll(',', '.')),
                  ),
                ),
              ),
              const Divider(thickness: 2.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Chip(
                  label: Text(
                    'Total: ${currency.format(state.total.toDouble())}',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.orange.shade600,
                  ),
                  onPressed: () {
                    print(state.cartItems);
                  },
                  child: const Text(
                    'Finalizar Venda',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
