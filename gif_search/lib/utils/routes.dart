import 'package:go_router/go_router.dart';

import '../screens/gif_detail.dart';
import '../screens/home_page.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home-page',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/gif-detail',
      name: 'gif-detail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return GifDetailScreen(data: data);
      },
    ),
  ],
);
