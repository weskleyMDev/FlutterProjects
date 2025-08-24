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

  static String m0(name) => "Olá, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add_cart": MessageLookupByLibrary.simpleMessage("Adicionar ao carrinho"),
    "already_in_cart": MessageLookupByLibrary.simpleMessage(
      "Já está no carrinho!",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cart_dialog_body": MessageLookupByLibrary.simpleMessage(
      "ainda há itens no carrinho",
    ),
    "cart_dialog_title": MessageLookupByLibrary.simpleMessage("Deseja sair?"),
    "clear_cart": MessageLookupByLibrary.simpleMessage("Limpar carrinho"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "default_username": MessageLookupByLibrary.simpleMessage("Usuário(a)"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "greeting": m0,
    "home": MessageLookupByLibrary.simpleMessage("Ínicio"),
    "leave": MessageLookupByLibrary.simpleMessage("Sair"),
    "new_sale": MessageLookupByLibrary.simpleMessage("Nova Venda"),
    "no_products": MessageLookupByLibrary.simpleMessage(
      "Nenhum produto encontrado!",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "price": MessageLookupByLibrary.simpleMessage("Preço"),
    "product_added": MessageLookupByLibrary.simpleMessage(
      "Produto adicionado ao carrinho!",
    ),
    "product_removed": MessageLookupByLibrary.simpleMessage(
      "Produto removido do carrinho!",
    ),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantidade"),
    "receipts": MessageLookupByLibrary.simpleMessage("Recibos"),
    "remove_cart": MessageLookupByLibrary.simpleMessage("Remover do carrinho"),
    "remove_product": MessageLookupByLibrary.simpleMessage("Remover produto"),
    "sales": MessageLookupByLibrary.simpleMessage("Vendas"),
    "search": MessageLookupByLibrary.simpleMessage("Buscar"),
    "set_quantity": MessageLookupByLibrary.simpleMessage(
      "Digite a quantidade desejada",
    ),
    "shopping_cart": MessageLookupByLibrary.simpleMessage(
      "Carrinho de compras",
    ),
    "signin": MessageLookupByLibrary.simpleMessage("Entrar"),
    "signout": MessageLookupByLibrary.simpleMessage("Sair"),
    "signup": MessageLookupByLibrary.simpleMessage("Registrar"),
    "stock": MessageLookupByLibrary.simpleMessage("Estoque"),
  };
}
