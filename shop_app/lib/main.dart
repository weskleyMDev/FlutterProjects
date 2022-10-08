import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.deepOrange,
        ),
        fontFamily: 'Lato',
      ),
      home: ProductsScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.productDetails:(context) => const ProductDetails(),
      },
    );
  }
}
