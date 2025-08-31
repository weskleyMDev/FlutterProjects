import 'package:admin_shop/blocs/login/login_form_bloc.dart';
import 'package:admin_shop/firebase_options.dart';
import 'package:admin_shop/generated/l10n.dart';
import 'package:admin_shop/utils/routes/app_routes.dart';
import 'package:admin_shop/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = MyTheme();
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginFormBloc())],
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
