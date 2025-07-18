import 'package:go_router/go_router.dart';

import '../components/login_home.dart';
import '../pages/stock_form_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginOrHome(),
    ),
    GoRoute(
      path: '/stock-form',
      builder: (context, state) => const StockFormPage(),
    ),
  ],
);