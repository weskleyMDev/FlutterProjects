import 'package:go_router/go_router.dart';
import 'package:shop_v2/components/products/product_details.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/screens/home/home_screen.dart';
import 'package:shop_v2/screens/login/login_screen.dart';
import 'package:shop_v2/screens/login/new_acc_screen.dart';
import 'package:shop_v2/screens/orders/orders_screen.dart';
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
          routes: [
            GoRoute(
              path: '/categories/products/product',
              name: 'product-details',
              builder: (context, state) {
                final product = state.extra as ProductModel;
                return ProductDetails(product: product);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: 'login-screen',
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          path: '/login/new-account',
          name: 'new-acc-screen',
          builder: (context, state) => const NewAccScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/orders',
      name: 'orders-screen',
      builder: (context, state) => OrdersScreen(),
    ),
  ],
);
