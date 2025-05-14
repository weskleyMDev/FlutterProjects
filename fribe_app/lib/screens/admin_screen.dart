import 'package:flutter/material.dart';
import 'package:fribe_app/screens/matrizstock_screen.dart';
import 'package:fribe_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'signup_screen.dart';
import 'stock_screen.dart';
import 'vendas_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fribé Cortes Especiais"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout().then((_) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('userRole');
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              });
            },
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final buttons = [
            _buildButton(
              context,
              'assets/images/stock.png',
              'Estoque Loja'.toUpperCase(),
              () => _moveToCategoryScreen(context, 'EstoqueLoja'),
            ),
            _buildButton(
              context,
              'assets/images/stock2.png',
              'Estoque Matriz'.toUpperCase(),
              () => _moveToCategoryScreen(context, 'EstoqueMatriz'),
            ),
            _buildButton(
              context,
              'assets/images/sales2.png',
              'Vendas'.toUpperCase(),
              () => _moveToCategoryScreen(context, 'Vendas'),
            ),
            _buildButton(
              context,
              'assets/images/teamwork.png',
              'Funcionários'.toUpperCase(),
              () => _moveToCategoryScreen(context, 'Funcionarios'),
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

  Widget _buildButton(
    BuildContext context,
    String imagePath,
    String category,
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
      case 'EstoqueLoja':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StockScreen()),
        );
        break;
      case 'EstoqueMatriz':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MatrizstockScreen()),
        );
        break;
      case 'Vendas':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VendasScreen()),
        );
        break;
      case 'Funcionarios':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SignupScreen()),
        );
        break;
      default:
        break;
    }
  }
}
