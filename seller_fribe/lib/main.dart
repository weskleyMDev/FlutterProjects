import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';
import 'package:seller_fribe/blocs/cart/cart_bloc.dart';
import 'package:seller_fribe/blocs/login/login_bloc.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/cubits/home_tab/home_tab_cubit.dart';
import 'package:seller_fribe/firebase_options.dart';
import 'package:seller_fribe/generated/l10n.dart';
import 'package:seller_fribe/repositories/products/product_repository.dart';
import 'package:seller_fribe/services/auth/auth_service.dart';
import 'package:seller_fribe/utils/routes/routes.dart';
import 'package:seller_fribe/utils/themes/fonts.dart';
import 'package:seller_fribe/utils/themes/theme.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(800, 600),
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      title: 'Seller Fribe',
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await Future.wait([windowManager.show(), windowManager.focus()]);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = createTextTheme(context, "Roboto", "Overpass");
    final theme = MaterialTheme(textTheme);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IAuthService>(create: (context) => AuthService()),
        RepositoryProvider<IProductRepository>(
          create: (context) => ProductRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authService: RepositoryProvider.of<IAuthService>(context),
            )..add(const AuthSubscribeRequested()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authService: RepositoryProvider.of<IAuthService>(context),
            ),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              productRepository: RepositoryProvider.of<IProductRepository>(
                context,
              ),
            )..add(const ProductSubscribeRequested()),
          ),
          BlocProvider<HomeTabCubit>(create: (context) => HomeTabCubit()),
          BlocProvider<CartBloc>(create: (context) => CartBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Seller Fribe',
          theme: theme.dark(),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: routes,
        ),
      ),
    );
  }
}
