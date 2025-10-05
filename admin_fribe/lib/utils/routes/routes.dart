import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/screens/new_product_screen.dart';
import 'package:admin_fribe/screens/product_sales_screen.dart';
import 'package:admin_fribe/widgets/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthManager()),
    GoRoute(
      path: '/edit-product',
      name: 'edit-product',
      pageBuilder: (context, state) {
        final product = state.extra as ProductModel?;
        return CustomTransitionPage(
          child: EditProductScreen(initialProduct: product),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.decelerate;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/product-sales',
      name: 'product-sales',
      builder: (context, state) {
        final weekId = state.extra as String?;
        if (weekId == null) {
          return const Scaffold(
            body: Center(child: Text('Semana não informada')),
          );
        }
        return ProductSalesScreen(weekId: weekId);
      },
    ),
  ],
);
