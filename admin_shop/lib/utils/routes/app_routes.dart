import 'package:admin_shop/screens/home_screen.dart';
import 'package:admin_shop/widgets/auth_manager.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthManager()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);
