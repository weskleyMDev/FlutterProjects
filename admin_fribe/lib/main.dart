import 'dart:io';
import 'dart:ui';

import 'package:admin_fribe/blocs/auth/auth_bloc.dart';
import 'package:admin_fribe/blocs/login_form/login_form_bloc.dart';
import 'package:admin_fribe/blocs/pending_sales/pending_sale_bloc.dart';
import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/blocs/update_amount/update_amount_bloc.dart';
import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:admin_fribe/cubits/home_tab/home_tab_cubit.dart';
import 'package:admin_fribe/firebase_options.dart';
import 'package:admin_fribe/generated/l10n.dart';
import 'package:admin_fribe/logs/update_amount_log.dart';
import 'package:admin_fribe/repositories/pending_sales/pending_sale_repository.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:admin_fribe/repositories/sales_receipt/isales_receipt_repository.dart';
import 'package:admin_fribe/services/auth/auth_service.dart';
import 'package:admin_fribe/utils/font/font.dart';
import 'package:admin_fribe/utils/routes/routes.dart';
import 'package:admin_fribe/utils/theme/theme.dart';
import 'package:admin_fribe/widgets/connectivity_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

import 'blocs/connectivity/connectivity_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

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
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Oxanium", "Quantico");
    final theme = MaterialTheme(textTheme);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ISalesReceiptRepository>(
          create: (context) => SalesReceiptRepository(),
        ),
        RepositoryProvider<IAuthService>(create: (context) => AuthService()),
        RepositoryProvider<IProductRepository>(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider<IPendingSaleRepository>(
          create: (context) => PendingSaleRepository(),
        ),
        RepositoryProvider<IUpdateAmountLog>(
          create: (context) => UpdateAmountLog(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SalesReceiptBloc(context.read<ISalesReceiptRepository>()),
          ),
          BlocProvider(create: (context) => HomeTabCubit()),
          BlocProvider(
            create: (context) =>
                LoginFormBloc(authService: context.read<IAuthService>()),
          ),
          BlocProvider(
            create: (context) =>
                AuthBloc(authService: context.read<IAuthService>())
                  ..add(const AuthSubscriptionRequested()),
          ),
          BlocProvider(
            create: (context) =>
                ProductBloc(context.read<IProductRepository>())
                  ..add(const LoadProductsStream()),
          ),
          BlocProvider(
            create: (context) =>
                PendingSaleBloc(context.read<IPendingSaleRepository>())
                  ..add(const FetchPendingSalesEvent()),
          ),
          BlocProvider(
            create: (context) {
              final locale = PlatformDispatcher.instance.locale.toLanguageTag();
              final now = DateTime.now();
              final currentMonth = now.month;
              final currentYear = now.year;

              return WeekSalesBloc(context.read<ISalesReceiptRepository>())
                ..add(
                  WeekSalesRequested(
                    locale: locale,
                    month: currentMonth,
                    year: currentYear,
                  ),
                );
            },
          ),
          BlocProvider(
            create: (context) => UpdateAmountBloc(
              context.read<IProductRepository>(),
              context.read<IUpdateAmountLog>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                ConnectivityBloc(Connectivity())..add(CheckConnectivity()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Admin Fribe',
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: ThemeMode.system,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: routes,
          builder: (context, child) {
            return ConnectivityManager(child: child!);
          },
        ),
      ),
    );
  }
}
