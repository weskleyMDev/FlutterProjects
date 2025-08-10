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

  @override
  String tshirt(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Camisetas',
      one: 'Camiseta',
    );
    return '$_temp0';
  }

  @override
  String jacket(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Casacos',
      one: 'Casaco',
    );
    return '$_temp0';
  }

  @override
  String pants(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Calças',
      one: 'Calça',
    );
    return '$_temp0';
  }

  @override
  String shorts(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bermudas',
      one: 'Bermuda',
    );
    return '$_temp0';
  }

  @override
  String get no_data_found => 'Nenhum dado encontrado!';

  @override
  String get size => 'Tamanho';

  @override
  String get add_to_cart => 'Adicionar ao carrinho';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get add_new_account => 'Adicionar nova conta';

  @override
  String get forgot_password => 'Esqueceu sua senha?';

  @override
  String get new_account => 'Nova Conta';

  @override
  String get user_name => 'Nome';

  @override
  String get select_image => 'Selecionar Imagem';

  @override
  String get enter_email => 'Por favor insira seu e-mail';

  @override
  String get enter_password => 'Por favor digite sua senha';

  @override
  String get enter_valid_email => 'Por favor insira um e-mail válido';

  @override
  String get password_length => 'A senha deve ter pelo menos 6 caracteres';
}
