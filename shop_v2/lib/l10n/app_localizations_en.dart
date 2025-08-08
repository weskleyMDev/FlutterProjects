// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get already_have_an_account => 'Already Have an Account';

  @override
  String get shop_clothings_v2 => 'Shop Clothings V2';

  @override
  String get sign_in => 'Sign In';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get news => 'News';

  @override
  String get home => 'Home';

  @override
  String product(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Products',
      one: 'Product',
    );
    return '$_temp0';
  }

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String tshirt(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'TShirts',
      one: 'TShirt',
    );
    return '$_temp0';
  }

  @override
  String jacket(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jackets',
      one: 'Jacket',
    );
    return '$_temp0';
  }

  @override
  String pants(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pants',
      one: 'Pants',
    );
    return '$_temp0';
  }

  @override
  String shorts(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Shorts',
      one: 'Shorts',
    );
    return '$_temp0';
  }

  @override
  String get no_data_found => 'No data found!';

  @override
  String get size => 'Size';

  @override
  String get add_to_cart => 'Add to cart';
}
