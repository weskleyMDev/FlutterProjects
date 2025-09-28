import 'package:go_router/go_router.dart';
import 'package:seller_fribe/screens/home_screen.dart';
import 'package:seller_fribe/screens/login_screen.dart';
import 'package:seller_fribe/screens/receipts_screen.dart';
import 'package:seller_fribe/widgets/auth_manager.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthManager()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/receipts',
      name: 'receipts',
      builder: (context, state) => const ReceiptsScreen(),
    ),
  ],
);
