import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_product.dart';
import '../models/cart.dart';
import '../models/order_list.dart';
import '../utils/app_routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<bool?> _showConfirmDialog(
    BuildContext context,
    String title,
    String message,
    bool isBuying,
  ) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(
                    isBuying
                        ? "Compra realizada com sucesso!"
                        : 'Carrinho limpo com sucesso!',
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<OrderList>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: LayoutBuilder(
        builder: (ctx, cont) {
          return cart.itemCount == 0
              ? Center(
                  child: Text(
                    'Carrinho vazio',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Chip(
                              label: Text(
                                'Total: R\$ ${cart.totalAmount.replaceAll('.', ',')}'
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.color,
                                ),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              onPressed: () async {
                                final bool?
                                isConfirmed = await _showConfirmDialog(
                                  context,
                                  'Limpar carrinho',
                                  'Você tem certeza que deseja limpar o carrinho?',
                                  false,
                                );
                                if (isConfirmed == true &&
                                    isConfirmed != null) {
                                  cart.clear();
                                }
                                if (!context.mounted) {
                                  return;
                                }
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoutes.homeScreen,
                                  (route) => false,
                                );
                              },
                              child: Text("Limpar".toUpperCase()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 10, child: CartProduct()),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: cart.itemCount > 0
          ? FloatingActionButton.extended(
              onPressed: () async {
                final bool? isConfirmed = await _showConfirmDialog(
                  context,
                  'Confirmar compra',
                  'Você tem certeza que deseja finalizar a compra?',
                  true,
                );
                if (isConfirmed == true && isConfirmed != null) {
                  order.addOrder(cart);
                  cart.clear();
                }
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.homeScreen,
                  (route) => false,
                );
              },
              label: Text(
                'Comprar'.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white, width: 1.0),
              ),
            )
          : null,
    );
  }
}
