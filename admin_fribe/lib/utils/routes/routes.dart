import 'package:admin_fribe/screens/new_product_screen.dart';
import 'package:admin_fribe/widgets/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthManager()),
    GoRoute(
      path: '/new-product',
      name: 'new-product',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: NewProductScreen(),
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
      ),
    ),
  ],
);
