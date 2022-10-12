import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/products_list.dart';
import 'screens/product_details.dart';
import 'screens/product_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsList(),
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primaryColor: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
          ).copyWith(
            secondary: Colors.orange,
          ),
          fontFamily: 'Lato',
        ),
        home: const ProductsScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.productDetails:(context) => const ProductDetails(),
        },
      ),
    );
  }
}
