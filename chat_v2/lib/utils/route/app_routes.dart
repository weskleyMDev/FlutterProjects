import 'package:chat_v2/screens/login/login_screen.dart';
import 'package:go_router/go_router.dart';

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
