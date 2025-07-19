import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/drawer_admin.dart';

class StockHomePage extends StatelessWidget {
  const StockHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESTOQUE')),
      drawer: DrawerAdmin(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push('/stock-bovine'),
          child: const Text('Bovinos'),
        ),
      ),
    );
  }
}
