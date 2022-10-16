import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/products_list.dart';
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
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
          canvasColor: const Color.fromRGBO(244, 237, 215, 1)
        ),
        home: const ProductsScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (context) => const ProductsScreen(),
          AppRoutes.productDetails: (context) => const ProductDetails(),
          AppRoutes.cart:(context) => const CartScreen(),
          AppRoutes.orders: (context) => const OrderScreen(),
        },
      ),
    );
  }
}
