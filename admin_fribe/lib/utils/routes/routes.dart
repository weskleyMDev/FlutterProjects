import 'package:admin_fribe/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => const HomeScreen())],
);
