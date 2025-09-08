import 'package:admin_shop/utils/capitalize_text.dart';
import 'package:flutter/material.dart';

enum Category { camisas, calcas, acessorios }

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Category.values;
    Widget showCategories(BuildContext context, int index) =>
        Card(child: ListTile(title: Text(categories[index].name.capitalize())));
    return Column(
      children: [
        ...List.generate(categories.length, (i) => showCategories(context, i)),
      ],
    );
  }
}
