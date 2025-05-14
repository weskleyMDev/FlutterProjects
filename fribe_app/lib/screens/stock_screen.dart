import 'package:flutter/material.dart';
import 'package:fribe_app/screens/stock/bovino_screen.dart';

import 'stock/aves_screen.dart';
import 'stock/caprino_screen.dart';
import 'stock/suino_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estoque Loja')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final buttons = [
            _buildCategoryButton(
              context,
              'BOVINO',
              'assets/images/cow.png',
              () => _moveToCategoryScreen(context, 'BOVINO'),
            ),
            _buildCategoryButton(
              context,
              'CAPRINO',
              'assets/images/goat.png',
              () => _moveToCategoryScreen(context, 'CAPRINO'),
            ),
            _buildCategoryButton(
              context,
              'SUÍNO',
              'assets/images/pig.png',
              () => _moveToCategoryScreen(context, 'SUÍNO'),
            ),
            _buildCategoryButton(
              context,
              'AVES',
              'assets/images/chicken.png',
              () => _moveToCategoryScreen(context, 'AVES'),
            ),
          ];
          if (orientation == Orientation.portrait) {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              physics: const AlwaysScrollableScrollPhysics(),
              children: buttons,
            );
          } else {
            return Row(children: buttons);
          }
        },
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String category,
    String imagePath,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(
              hoverColor: Theme.of(context).colorScheme.primary,
              onPressed: onPressed,
              icon: Image.asset(imagePath, height: 100, width: 150),
            ),
            Text(
              textAlign: TextAlign.center,
              category,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _moveToCategoryScreen(BuildContext context, String category) {
    switch (category) {
      case 'BOVINO':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BovinoScreen()),
        );
        break;
      case 'CAPRINO':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CaprinoScreen()),
        );
        break;
      case 'SUÍNO':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SuinoScreen()),
        );
        break;
      case 'AVES':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AvesScreen()),
        );
        break;
      default:
        break;
    }
  }

  // void _showBottomModal(BuildContext context, String category) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'Categoria: $category',
  //               style: const TextStyle(
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               'Você clicou em $category. Este é um modal exibido na parte inferior da tela.',
  //               style: const TextStyle(fontSize: 16),
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Fechar'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
