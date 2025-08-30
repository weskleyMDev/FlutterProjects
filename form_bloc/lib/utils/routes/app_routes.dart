import 'package:form_bloc/components/auth_manager.dart';
import 'package:form_bloc/screens/report_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home-screen',
      builder: (context, state) => const AuthManager(),
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
