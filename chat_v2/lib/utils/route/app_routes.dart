import 'package:chat_v2/components/login/login_or_home.dart';
import 'package:go_router/go_router.dart';

//final _loginStore = GetIt.instance<LoginFormStore>();
final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login-screen',
      builder: (context, state) => LoginOrHome(),
    ),
  ],
);
