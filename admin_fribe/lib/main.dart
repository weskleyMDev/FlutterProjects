import 'package:admin_fribe/blocs/auth/auth_bloc.dart';
import 'package:admin_fribe/blocs/login_form/login_form_bloc.dart';
import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/cubits/home_tab/home_tab_cubit.dart';
import 'package:admin_fribe/firebase_options.dart';
import 'package:admin_fribe/generated/l10n.dart';
import 'package:admin_fribe/repositories/sales_receipt/isales_receipt_repository.dart';
import 'package:admin_fribe/services/auth/auth_service.dart';
import 'package:admin_fribe/utils/font/font.dart';
import 'package:admin_fribe/utils/routes/routes.dart';
import 'package:admin_fribe/utils/theme/theme.dart';
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

  WindowOptions windowOptions = WindowOptions(
    size: const Size(800, 600),
    minimumSize: const Size(800, 600),
    title: "Admin Fribe",
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
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
    TextTheme textTheme = createTextTheme(context, "Nunito Sans", "Lora");
    final theme = MaterialTheme(textTheme);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ISalesReceiptRepository>(
          create: (context) => SalesReceiptRepository(),
        ),
        RepositoryProvider<IAuthService>(create: (context) => AuthService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SalesReceiptBloc(
              RepositoryProvider.of<ISalesReceiptRepository>(context),
            )..add(const LoadSalesReceipts()),
          ),
          BlocProvider(create: (context) => HomeTabCubit()),
          BlocProvider(
            create: (context) => LoginFormBloc(
              authService: RepositoryProvider.of<IAuthService>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authService: RepositoryProvider.of<IAuthService>(context),
            )..add(const AuthSubscriptionRequested()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Admin Fribe',
          debugShowCheckedModeBanner: false,
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
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
