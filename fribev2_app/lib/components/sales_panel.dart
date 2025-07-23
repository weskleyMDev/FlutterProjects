import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../stores/cart.store.dart';
import '../stores/stock.store.dart';

class SalesPanel extends StatefulWidget {
  const SalesPanel({super.key});

  @override
  State<SalesPanel> createState() => _SalesPanelState();
}

class _SalesPanelState extends State<SalesPanel> {
  Future<bool?> _showDialogQuantity({
    required BuildContext context,
    required CartStore store,
  }) async {
    final formKey = GlobalKey<FormState>();
    store.setQuantity('');
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Digite a quantidade desejada'),
        content: Form(
          key: formKey,
          child: TextFormField(
            key: ValueKey('quantity'),
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Quantidade'),
            ),
            onChanged: (value) => store.setQuantity(value),
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
              store.setQuantity('');
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

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context);
    final cartStore = Provider.of<CartStore>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Observer(
        builder: (context) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 4.0,
                  right: 4.0,
                  bottom: 8.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Buscar'),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => stockStore.searchQuery = value,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: stockStore.filterList,
                  builder: (context, asyncSnapshot) {
                    switch (asyncSnapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        return StreamBuilder(
                          stream: stockStore.productsList,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                      'Erro ao buscar dados do banco!',
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Nenhum produto encontrado!'),
                                  );
                                } else {
                                  final products = snapshot.data ?? [];
                                  return ListView.builder(
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      final product = products[index];
                                      return Card(
                                        shape: RoundedRectangleBorder(),
                                        child: ListTile(
                                          title: Text(
                                            product.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            'Preço: R\$ ${double.parse(product.price).toStringAsFixed(2).replaceAll('.', ',')} | Estoque: ${double.parse(product.amount).toStringAsFixed(3).replaceAll('.', ',')} (${product.measure})',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: ElevatedButton.icon(
                                            onPressed: () async {
                                              try {
                                                final isConfirmed =
                                                    await _showDialogQuantity(
                                                      context: context,
                                                      store: cartStore,
                                                    );
                                                if (isConfirmed == true) {
                                                  cartStore.addItem(
                                                    product: product,
                                                  );
                                                } else {
                                                  return;
                                                }
                                              } catch (e) {
                                                if (!context.mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).clearSnackBars();
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      e.toString().replaceAll(
                                                        'Exception: ',
                                                        '',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            label: Icon(Icons.add_outlined),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                            }
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
