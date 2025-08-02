// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputFormStore on InputFormStoreBase, Store {
  Computed<String>? _$textComputed;

  @override
  String get text => (_$textComputed ??= Computed<String>(
    () => super.text,
    name: 'InputFormStoreBase.text',
  )).value;
  Computed<bool>? _$isWritingComputed;

  @override
  bool get isWriting => (_$isWritingComputed ??= Computed<bool>(
    () => super.isWriting,
    name: 'InputFormStoreBase.isWriting',
  )).value;
  Computed<FutureStatus>? _$statusComputed;

  @override
  FutureStatus get status => (_$statusComputed ??= Computed<FutureStatus>(
    () => super.status,
    name: 'InputFormStoreBase.status',
  )).value;
  Computed<List<Message>>? _$messagesComputed;

  @override
  List<Message> get messages => (_$messagesComputed ??= Computed<List<Message>>(
    () => super.messages,
    name: 'InputFormStoreBase.messages',
  )).value;

  late final _$_isWritingAtom = Atom(
    name: 'InputFormStoreBase._isWriting',
    context: context,
  );

  @override
  bool get _isWriting {
    _$_isWritingAtom.reportRead();
    return super._isWriting;
  }

  @override
  set _isWriting(bool value) {
    _$_isWritingAtom.reportWrite(value, super._isWriting, () {
      super._isWriting = value;
    });
  }

  late final _$_textAtom = Atom(
    name: 'InputFormStoreBase._text',
    context: context,
  );

  @override
  String get _text {
    _$_textAtom.reportRead();
    return super._text;
  }

  @override
  set _text(String value) {
    _$_textAtom.reportWrite(value, super._text, () {
      super._text = value;
    });
  }

  late final _$_futureMessagesAtom = Atom(
    name: 'InputFormStoreBase._futureMessages',
    context: context,
  );

  @override
  ObservableFuture<List<Message>> get _futureMessages {
    _$_futureMessagesAtom.reportRead();
    return super._futureMessages;
  }

  @override
  set _futureMessages(ObservableFuture<List<Message>> value) {
    _$_futureMessagesAtom.reportWrite(value, super._futureMessages, () {
      super._futureMessages = value;
    });
  }

  late final _$_messagesAtom = Atom(
    name: 'InputFormStoreBase._messages',
    context: context,
  );

  @override
  ObservableList<Message> get _messages {
    _$_messagesAtom.reportRead();
    return super._messages;
  }

  @override
  set _messages(ObservableList<Message> value) {
    _$_messagesAtom.reportWrite(value, super._messages, () {
      super._messages = value;
    });
  }

  late final _$fetchMessagesAsyncAction = AsyncAction(
    'InputFormStoreBase.fetchMessages',
    context: context,
  );

  @override
  Future<void> fetchMessages() {
    return _$fetchMessagesAsyncAction.run(() => super.fetchMessages());
  }

  late final _$sendMessageAsyncAction = AsyncAction(
    'InputFormStoreBase.sendMessage',
    context: context,
  );

  @override
  Future<void> sendMessage() {
    return _$sendMessageAsyncAction.run(() => super.sendMessage());
  }

  late final _$initAsyncAction = AsyncAction(
    'InputFormStoreBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$InputFormStoreBaseActionController = ActionController(
    name: 'InputFormStoreBase',
    context: context,
  );

  @override
  void clearForm() {
    final _$actionInfo = _$InputFormStoreBaseActionController.startAction(
      name: 'InputFormStoreBase.clearForm',
    );
    try {
      return super.clearForm();
    } finally {
      _$InputFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
text: ${text},
isWriting: ${isWriting},
status: ${status},
messages: ${messages}
    ''';
  }
}
