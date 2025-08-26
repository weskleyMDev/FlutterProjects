import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.stockStore});

  final StockStore stockStore;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  Future<bool?> _confirmDelete() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remover Produto?'),
          content: Text('Deseja realmente remover este produto?'),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => context.pop(true),
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final locale = Localizations.localeOf(context).languageCode;
        final numFormat = NumberFormat.compact(locale: locale);
        final currencyFormat = NumberFormat.simpleCurrency(locale: locale);
        final products = widget.stockStore.filteredProducts;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            final amount = numFormat.format(double.parse(product.amount));
            final price = currencyFormat.format(double.parse(product.price));
            return Card(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        context.pushNamed('stock-edit-form', extra: product);
                      },
                      icon: Icons.edit,
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.transparent,
                      label: 'Editar',
                      padding: EdgeInsets.zero,
                    ),
                    SlidableAction(
                      onPressed: (_) async {
                        final confirm = await _confirmDelete();
                        if (confirm == true) {
                          widget.stockStore.removeProductById(product: product);
                        }
                      },
                      icon: Icons.delete_forever,
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.transparent,
                      label: 'Remover',
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(12.0),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: Text('${product.name} - $price'),
                    subtitle: Text('Estoque: $amount(${product.measure})'),
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
