import 'package:form_bloc/screens/login_screen.dart';
import 'package:form_bloc/screens/report_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home-screen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/reports',
      name: 'report-screen',
      builder: (context, state) {
        final userId = state.extra as String;
        return ReportScreen(userId: userId);
      },
    ),
  ],
);
