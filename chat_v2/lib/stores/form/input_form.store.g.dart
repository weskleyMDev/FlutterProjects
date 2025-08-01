// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputFormStore on InputFormStoreBase, Store {
  late final _$isWritingAtom = Atom(
    name: 'InputFormStoreBase.isWriting',
    context: context,
  );

  @override
  bool get isWriting {
    _$isWritingAtom.reportRead();
    return super.isWriting;
  }

  @override
  set isWriting(bool value) {
    _$isWritingAtom.reportWrite(value, super.isWriting, () {
      super.isWriting = value;
    });
  }

  @override
  String toString() {
    return '''
isWriting: ${isWriting}
    ''';
  }
}
