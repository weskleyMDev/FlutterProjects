import 'package:go_router/go_router.dart';

import '../screens/home_page.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home-page',
      builder: (context, state) => HomePage(),
    ),
  ],
);
