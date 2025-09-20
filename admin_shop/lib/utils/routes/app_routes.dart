import 'package:admin_shop/models/product_model.dart';
import 'package:admin_shop/screens/home_screen.dart';
import 'package:admin_shop/screens/product_edit_screen.dart';
import 'package:admin_shop/widgets/auth_manager.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthManager()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/product-edit',
      name: 'product-edit',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final category = extras['category'] as String;
        final product = extras['product'] as ProductModel?;
        return ProductEditScreen(category: category, product: product);
      },
    ),
  ],
);
