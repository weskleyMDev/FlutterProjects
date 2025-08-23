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

  static String m0(name) => "Hello, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add_cart": MessageLookupByLibrary.simpleMessage("Add to cart"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cart_dialog_body": MessageLookupByLibrary.simpleMessage(
      "there are still items in your cart",
    ),
    "cart_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Do you want to leave?",
    ),
    "clear_cart": MessageLookupByLibrary.simpleMessage("Clear cart"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "default_username": MessageLookupByLibrary.simpleMessage("User"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "greeting": m0,
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "leave": MessageLookupByLibrary.simpleMessage("Leave"),
    "new_sale": MessageLookupByLibrary.simpleMessage("New Sale"),
    "no_products": MessageLookupByLibrary.simpleMessage("No products found!"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "price": MessageLookupByLibrary.simpleMessage("Price"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "receipts": MessageLookupByLibrary.simpleMessage("Receipts"),
    "remove_cart": MessageLookupByLibrary.simpleMessage("Remove from cart"),
    "sales": MessageLookupByLibrary.simpleMessage("Sales"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "set_quantity": MessageLookupByLibrary.simpleMessage(
      "Enter the desired quantity",
    ),
    "shopping_cart": MessageLookupByLibrary.simpleMessage("Shopping Cart"),
    "signin": MessageLookupByLibrary.simpleMessage("Sign in"),
    "signout": MessageLookupByLibrary.simpleMessage("Sign out"),
    "signup": MessageLookupByLibrary.simpleMessage("Sign up"),
    "stock": MessageLookupByLibrary.simpleMessage("Stock"),
  };
}
