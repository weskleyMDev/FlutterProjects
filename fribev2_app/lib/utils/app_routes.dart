import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/login_home.dart';
import '../pages/stock_form_page.dart';
import '../stores/auth.store.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginOrHome()),
    GoRoute(
      path: '/stock-form',
      builder: (context, state) => const StockFormPage(),
      redirect: (context, state) {
        final authStore = Provider.of<AuthStore>(context, listen: false);
        final userId = authStore.currentUser?.id;
        final userRole = authStore.currentUser?.role;
        if (userId == null || userRole != 'admin') {
          return '/';
        } else {
          return null;
        }
      },
    ),
  ],
);
