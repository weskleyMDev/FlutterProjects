import 'package:go_router/go_router.dart';
import 'package:seller_fribe/screens/pending_sales_screen.dart';
import 'package:seller_fribe/screens/receipts_screen.dart';
import 'package:seller_fribe/widgets/auth_manager.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const AuthManager(),
    ),
    GoRoute(
      path: '/receipts',
      name: 'receipts',
      builder: (context, state) => const ReceiptsScreen(),
    ),
    GoRoute(
      path: '/pending_sales',
      name: 'pending_sales',
      builder: (context, state) => const PendingSalesScreen(),
    ),
  ],
);
