import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/firebase_options.dart';
import 'package:admin_fribe/generated/l10n.dart';
import 'package:admin_fribe/repositories/sales_receipt/isales_receipt_repository.dart';
import 'package:admin_fribe/utils/font/font.dart';
import 'package:admin_fribe/utils/routes/routes.dart';
import 'package:admin_fribe/utils/theme/theme.dart';
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
    TextTheme textTheme = createTextTheme(context, "Nunito Sans", "Lora");
    final theme = MaterialTheme(textTheme);
    return RepositoryProvider<ISalesReceiptRepository>(
      create: (context) => SalesReceiptRepository(),
      child: BlocProvider(
        create: (context) => SalesReceiptBloc(
          RepositoryProvider.of<ISalesReceiptRepository>(context),
        )..add(const LoadSalesReceipts()),
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
