import 'package:admin_fribe/models/product_model.dart';
import 'package:flutter/material.dart';

class UpdateAmountDialog extends StatelessWidget {
  const UpdateAmountDialog({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(product.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'New Amount'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: () {}, child: const Text('Update')),
      ],
    );
  }
}
