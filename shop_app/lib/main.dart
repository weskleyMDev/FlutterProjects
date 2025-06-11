import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/utils/app_logger.dart';

import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/product_list.dart';
import 'providers/auth_login.dart';
import 'screens/auth_home.dart';
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
import 'screens/product_details.dart';
import 'screens/product_form.dart';
import 'screens/product_screen.dart';
import 'theme/theme.dart';
import 'utils/app_routes.dart';

Future<void> main() async {
  AppLogger.init(isProduction: false);
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthLogin.instance),
        ChangeNotifierProxyProvider<AuthLogin, ProductList>(
          create: (_) {
            return ProductList();
          },
          update: (ctx, auth, previous) => ProductList(
            auth.token ?? '',
            auth.uid ?? '',
            previous?.items ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<AuthLogin, OrderList>(
          create: (_) {
            return OrderList();
          },
          update: (ctx, auth, previous) => OrderList(
            auth.token ?? '',
            auth.uid ?? '',
            previous?.orders ?? [],
          ),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
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
          AppRoutes.authScreen: (context) => const AuthOrHome(),
          AppRoutes.productDetails: (context) => const ProductDetails(),
          AppRoutes.cartScreen: (context) => const CartScreen(),
          AppRoutes.orders: (context) => const OrderScreen(),
          AppRoutes.productScreen: (context) => const ProductScreen(),
          AppRoutes.productForm: (context) => const ProductForm(),
        },
      ),
    );
  }
}
