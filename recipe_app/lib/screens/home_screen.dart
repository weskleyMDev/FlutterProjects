import 'package:flutter/material.dart';

import '../components/category_item.dart';
import '../data/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sortedCategories = dummyCategories
      ..sort((a, b) => a.title.compareTo(b.title));

    return GridView(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      children: sortedCategories
          .map((category) => CategoryItem(category: category))
          .toList(),
    );
  }
}
