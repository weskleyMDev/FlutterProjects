// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get hello => 'Olá';

  @override
  String get already_have_an_account => 'Já possui uma conta';

  @override
  String get shop_clothings_v2 => 'Loja de Roupas V2';

  @override
  String get sign_in => 'Entrar';

  @override
  String get sign_up => 'Registrar';

  @override
  String get sign_out => 'Sair';

  @override
  String get news => 'Novidades';

  @override
  String get home => 'Início';

  @override
  String product(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Produtos',
      one: 'Produto',
    );
    return '$_temp0';
  }

  @override
  String get orders => 'Pedidos';

  @override
  String get profile => 'Perfil';
}
