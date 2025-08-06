import 'package:go_router/go_router.dart';
import 'package:shop_v2/screens/home/home_screen.dart';
import 'package:shop_v2/screens/products/products_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home-screen',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/products',
      name: 'products-categories',
      builder: (context, state) => ProductsScreen(),
    ),
  ],
);
