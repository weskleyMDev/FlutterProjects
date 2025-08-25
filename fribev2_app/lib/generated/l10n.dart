// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello, {name}`
  String greeting(String name) {
    return Intl.message(
      'Hello, $name',
      name: 'greeting',
      desc: 'default greeting message',
      args: [name],
    );
  }

  /// `User`
  String get default_username {
    return Intl.message(
      'User',
      name: 'default_username',
      desc: 'default username label',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message(
      'Stock',
      name: 'stock',
      desc: 'stock button text',
      args: [],
    );
  }

  /// `Receipts`
  String get receipts {
    return Intl.message(
      'Receipts',
      name: 'receipts',
      desc: 'receipts button text',
      args: [],
    );
  }

  /// `Sales`
  String get sales {
    return Intl.message(
      'Sales',
      name: 'sales',
      desc: 'sales button text',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'home button text',
      args: [],
    );
  }

  /// `Sign out`
  String get signout {
    return Intl.message(
      'Sign out',
      name: 'signout',
      desc: 'sign out button text',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'password label text',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'email label text',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message(
      'Sign in',
      name: 'signin',
      desc: 'sign in button text',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: 'sign up button text',
      args: [],
    );
  }

  /// `Enter the desired quantity`
  String get set_quantity {
    return Intl.message(
      'Enter the desired quantity',
      name: 'set_quantity',
      desc: 'quantity dialog label text',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: 'quantity text field label',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'cancel button text',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: 'confirm button text',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: 'search text field label',
      args: [],
    );
  }

  /// `New Sale`
  String get new_sale {
    return Intl.message(
      'New Sale',
      name: 'new_sale',
      desc: 'new sale label text',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: 'leave button text',
      args: [],
    );
  }

  /// `there are still items in your cart`
  String get cart_dialog_body {
    return Intl.message(
      'there are still items in your cart',
      name: 'cart_dialog_body',
      desc: 'cart dialog label text',
      args: [],
    );
  }

  /// `Do you want to leave?`
  String get cart_dialog_title {
    return Intl.message(
      'Do you want to leave?',
      name: 'cart_dialog_title',
      desc: 'cart dialog label text',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: 'shopping cart label text',
      args: [],
    );
  }

  /// `Add to cart`
  String get add_cart {
    return Intl.message(
      'Add to cart',
      name: 'add_cart',
      desc: 'add to cart tooltip text',
      args: [],
    );
  }

  /// `Remove from cart`
  String get remove_cart {
    return Intl.message(
      'Remove from cart',
      name: 'remove_cart',
      desc: 'remove from cart tooltip text',
      args: [],
    );
  }

  /// `Clear cart`
  String get clear_cart {
    return Intl.message(
      'Clear cart',
      name: 'clear_cart',
      desc: 'clear cart tooltip text',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: 'price label text',
      args: [],
    );
  }

  /// `No products found!`
  String get no_products {
    return Intl.message(
      'No products found!',
      name: 'no_products',
      desc: 'no products label text',
      args: [],
    );
  }

  /// `Already in cart!`
  String get already_in_cart {
    return Intl.message(
      'Already in cart!',
      name: 'already_in_cart',
      desc: 'already in cart label text',
      args: [],
    );
  }

  /// `Product added to cart!`
  String get product_added {
    return Intl.message(
      'Product added to cart!',
      name: 'product_added',
      desc: 'product added to cart label text',
      args: [],
    );
  }

  /// `Remove product`
  String get remove_product {
    return Intl.message(
      'Remove product',
      name: 'remove_product',
      desc: 'remove product tooltip text',
      args: [],
    );
  }

  /// `Product removed from cart!`
  String get product_removed {
    return Intl.message(
      'Product removed from cart!',
      name: 'product_removed',
      desc: 'product removed from cart label text',
      args: [],
    );
  }

  /// `This field is required!`
  String get required_field {
    return Intl.message(
      'This field is required!',
      name: 'required_field',
      desc: 'required field label text',
      args: [],
    );
  }

  /// `Enter only numbers with up to 3 decimal places!`
  String get decimal_valid {
    return Intl.message(
      'Enter only numbers with up to 3 decimal places!',
      name: 'decimal_valid',
      desc: 'decimal valid error text',
      args: [],
    );
  }

  /// `Enter only integers greater than 0!`
  String get integer_valid {
    return Intl.message(
      'Enter only integers greater than 0!',
      name: 'integer_valid',
      desc: 'integer valid error text',
      args: [],
    );
  }

  /// `Quantity out of stock!`
  String get quantity_out {
    return Intl.message(
      'Quantity out of stock!',
      name: 'quantity_out',
      desc: 'quantity out of stock error text',
      args: [],
    );
  }

  /// `Add Payment`
  String get add_payment {
    return Intl.message(
      'Add Payment',
      name: 'add_payment',
      desc: 'add payment button text',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
