// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(name) => "Bem vindo, ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "clients": MessageLookupByLibrary.simpleMessage("Clientes"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "greeting": m0,
    "have_account": MessageLookupByLibrary.simpleMessage(
      "Já tem uma conta? Faça login.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Entrar"),
    "logout": MessageLookupByLibrary.simpleMessage("Sair"),
    "name": MessageLookupByLibrary.simpleMessage("Nome"),
    "no_account": MessageLookupByLibrary.simpleMessage(
      "Ainda não tem uma conta? Cadastre-se.",
    ),
    "orders": MessageLookupByLibrary.simpleMessage("Pedidos"),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "products": MessageLookupByLibrary.simpleMessage("Produtos"),
    "register": MessageLookupByLibrary.simpleMessage("Cadastrar"),
  };
}
