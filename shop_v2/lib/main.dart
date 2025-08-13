import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/firebase_options.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/repositories/cart/cart_repository.dart';
import 'package:shop_v2/repositories/products/products_repository.dart';
import 'package:shop_v2/services/auth/firebase_service.dart';
import 'package:shop_v2/services/cart/cart_service.dart';
import 'package:shop_v2/services/showcase/showcase_service.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/auth/auth_form.store.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';
import 'package:shop_v2/stores/components/drawer.store.dart';
import 'package:shop_v2/stores/products/products.store.dart';
import 'package:shop_v2/stores/showcase/showcase.store.dart';
import 'package:shop_v2/utils/routes/app_routes.dart';
import 'package:shop_v2/utils/theme/theme.dart';

final getIt = GetIt.instance;
void _setup() {
  getIt.registerLazySingleton(() => AuthStore(authService: FirebaseService()));
  getIt.registerLazySingleton(
    () => ShowcaseStore(showcaseService: ShowcaseService()),
  );
  getIt.registerLazySingleton(() => DrawerStore());
  getIt.registerLazySingleton(
    () => ProductsStore(productsRepository: ProductsRepository()),
  );
  getIt.registerLazySingleton(
    () => AuthFormStore(authService: FirebaseService()),
  );
  getIt.registerLazySingleton(
    () =>
        CartStore(cartRepository: CartRepository(), cartService: CartService()),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setup();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = CustomTheme();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Shop V2',
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: routes,
    );
  }
}
