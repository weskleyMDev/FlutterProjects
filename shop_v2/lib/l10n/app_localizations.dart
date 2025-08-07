import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// Greeting message
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Asking if user already has an account
  ///
  /// In en, this message translates to:
  /// **'Already Have an Account'**
  String get already_have_an_account;

  /// App Name
  ///
  /// In en, this message translates to:
  /// **'Shop Clothings V2'**
  String get shop_clothings_v2;

  /// Label for sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// Label for sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// Label for sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// Label for news screen
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// Label for home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for products screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Product} other{Products}}'**
  String product(num count);

  /// Label for orders screen
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// Label for profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Label for tshirts screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Tshirt} other{Tshirts}}'**
  String tshirt(num count);

  /// Label for jackets screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Jacket} other{Jackets}}'**
  String jacket(num count);

  /// Label for pants screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Pants} other{Pants}}'**
  String pants(num count);

  /// Label for shorts screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Shorts} other{Shorts}}'**
  String shorts(num count);

  /// Label for no data found
  ///
  /// In en, this message translates to:
  /// **'No data found!'**
  String get no_data_found;

  /// Label for size
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
