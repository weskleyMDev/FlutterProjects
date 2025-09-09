// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Welcome, ${name}!";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'No Jacket', one: 'Jacket', other: 'Jackets')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'No Pants', one: 'Pants', other: 'Pants')}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'No Shirt', one: 'Shirt', other: 'Shirts')}";

  static String m4(count) =>
      "${Intl.plural(count, zero: 'No Shorts', one: 'Shorts', other: 'Shorts')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "clients": MessageLookupByLibrary.simpleMessage("Clients"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "greeting": m0,
    "have_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Sign In.",
    ),
    "jacket": m1,
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "no_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account yet? Sign up.",
    ),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "pants": m2,
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "products": MessageLookupByLibrary.simpleMessage("Products"),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "shirt": m3,
    "shorts": m4,
  };
}
