import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/app_logger.dart';

import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/product_list.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/order_screen.dart';
import 'screens/product_details.dart';
import 'screens/product_form.dart';
import 'screens/product_screen.dart';
import 'theme/theme.dart';
import 'utils/app_routes.dart';

void main() {
  AppLogger.init(isProduction: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList.instance),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: purpleLightTheme,
        darkTheme: purpleDarkTheme,
        themeMode: ThemeMode.system,
        routes: {
          AppRoutes.productDetails: (context) => const ProductDetails(),
          AppRoutes.cartScreen: (context) => const CartScreen(),
          AppRoutes.orders: (context) => const OrderScreen(),
          AppRoutes.homeScreen: (context) =>
              const MyHomePage(title: 'Minha Loja'),
          AppRoutes.productScreen: (context) => const ProductScreen(),
          AppRoutes.productForm: (context) => const ProductForm(),
        },
      ),
    );
  }
}
