import 'package:go_router/go_router.dart';
import 'package:shop_v2/screens/home/home_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home-screen',
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
