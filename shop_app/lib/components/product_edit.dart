import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';
import '../utils/app_routes.dart';

class ProductEdit extends StatefulWidget {
  const ProductEdit({super.key, required this.product});

  final Product product;

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  Future<bool?> _showConfirmDialog(
    BuildContext context,
    String title,
    String message,
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
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context, listen: false);
    final message = ScaffoldMessenger.of(context);
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Slidable(
        key: ValueKey(widget.product.id),
        endActionPane: ActionPane(
          motion: BehindMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.productForm, arguments: widget.product);
              },
              icon: Icons.edit_sharp,
              label: "Editar",
              backgroundColor: Colors.blueAccent,
            ),
            SlidableAction(
              onPressed: (context) async {
                try {
                  final bool? confirm = await _showConfirmDialog(
                    context,
                    "Excluir Produto",
                    "Você tem certeza que deseja excluir este produto?",
                  );

                  if (confirm != null && confirm) {
                    try {
                      await productList.removeProduct(widget.product);
                    } catch (e) {
                      message.showSnackBar(SnackBar(content: Text('$e')));
                    }
                  }
                } catch (e) {
                  rethrow;
                }
              },
              icon: Icons.delete_sharp,
              label: "Excluir",
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ],
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 0.0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1.0,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.product.imageUrl),
            ),
            title: Text(widget.product.title),
            subtitle: Text("R\$ ${widget.product.price.replaceAll(".", ",")}"),
          ),
        ),
      ),
    );
  }
}
