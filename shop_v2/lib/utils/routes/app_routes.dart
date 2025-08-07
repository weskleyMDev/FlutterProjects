import 'package:go_router/go_router.dart';
import 'package:shop_v2/screens/home/home_screen.dart';
import 'package:shop_v2/screens/products/categories_screen.dart';
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
      path: '/categories',
      name: 'categories-screen',
      builder: (context, state) => CategoriesScreen(),
      routes: [
        GoRoute(
          path: '/categories/products',
          name: 'products-screen',
          builder: (context, state) => ProductsScreen(),
        ),
      ],
    ),
  ],
);
