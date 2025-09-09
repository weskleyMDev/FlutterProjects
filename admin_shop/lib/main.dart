import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/blocs/login_form/login_form_bloc.dart';
import 'package:admin_shop/blocs/orders/order_bloc.dart';
import 'package:admin_shop/blocs/products/product_bloc.dart';
import 'package:admin_shop/blocs/users/user_bloc.dart';
import 'package:admin_shop/firebase_options.dart';
import 'package:admin_shop/generated/l10n.dart';
import 'package:admin_shop/repositories/clients/user_repository.dart';
import 'package:admin_shop/repositories/orders/order_repository.dart';
import 'package:admin_shop/repositories/products/product_repository.dart';
import 'package:admin_shop/services/auth/auth_service.dart';
import 'package:admin_shop/utils/routes/app_routes.dart';
import 'package:admin_shop/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    windowManager.ensureInitialized(),
  ]);
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: 'Admin Shop',
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await Future.wait([windowManager.show(), windowManager.focus()]);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = MyTheme();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginFormBloc()),
        BlocProvider(
          create: (context) =>
              AuthBloc(AuthService())..add(UserChangesRequested()),
        ),
        BlocProvider(
          create: (context) =>
              OrderBloc(OrderRepository())
                ..add(OrdersOverviewSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) =>
              UserBloc(UserRepository())
                ..add(UsersOverviewSubscriptionRequested()),
        ),
        BlocProvider(create: (context) => ProductBloc(ProductRepository())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Admin Shop',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: routes,
      ),
    );
  }
}
