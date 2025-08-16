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

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgot_password => 'Forgot your password?';

  @override
  String get new_account => 'New Account';

  @override
  String get user_name => 'Name';

  @override
  String get select_image => 'Select Image';

  @override
  String get enter_email => 'Please enter your email';

  @override
  String get enter_password => 'Please enter your password';

  @override
  String get enter_valid_email => 'Please enter a valid email';

  @override
  String get password_length => 'Password must be at least 6 characters';

  @override
  String get enter_name => 'Please enter your name';

  @override
  String get name_length => 'Name must be at least 3 characters';

  @override
  String get enter_to_buy => 'Please enter to buy';

  @override
  String item(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: 'item',
      zero: 'no items',
    );
    return '$_temp0';
  }

  @override
  String get my_cart => 'My Cart';

  @override
  String get confirm_order => 'Confirm Order';

  @override
  String get remove_from_cart => 'Remove from cart';

  @override
  String get order_summary => 'Order Summary';

  @override
  String get discount => 'Discount';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get shipping => 'Shipping fee';

  @override
  String get shipping_calculator => 'Shipping Calculator';

  @override
  String get promo_code => 'Promo Code';

  @override
  String get quantity => 'Quantity';
}
