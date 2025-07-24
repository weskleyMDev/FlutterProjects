import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StockHomePage extends StatefulWidget {
  const StockHomePage({super.key});

  @override
  State<StockHomePage> createState() => _StockHomePageState();
}

class _StockHomePageState extends State<StockHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESTOQUE')),
      body: GridView(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        children: [
          ElevatedButton(
            onPressed: () => context.pushNamed(
              'stock-category',
              pathParameters: {'title': 'BOVINO', 'category': 'BOVINO'},
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text('Bovinos'),
          ),
          ElevatedButton(
            onPressed: () => context.pushNamed(
              'stock-category',
              pathParameters: {'title': 'OVINO', 'category': 'OVINO'},
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text('Ovinos'),
          ),
          ElevatedButton(
            onPressed: () => context.pushNamed(
              'stock-category',
              pathParameters: {'title': 'AVES', 'category': 'AVES'},
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text('Aves'),
          ),
          ElevatedButton(
            onPressed: () => context.pushNamed(
              'stock-category',
              pathParameters: {'title': 'OUTROS', 'category': 'OUTROS'},
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text('Outros'),
          ),
        ],
      ),
    );
  }
}
