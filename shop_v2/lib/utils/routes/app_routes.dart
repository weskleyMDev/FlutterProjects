import 'package:go_router/go_router.dart';
import 'package:shop_v2/screens/login_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login-screen',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
