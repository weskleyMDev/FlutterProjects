// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputFormStore on InputFormStoreBase, Store {
  Computed<Map<String, dynamic>>? _$formDataComputed;

  @override
  Map<String, dynamic> get formData =>
      (_$formDataComputed ??= Computed<Map<String, dynamic>>(
        () => super.formData,
        name: 'InputFormStoreBase.formData',
      )).value;
  Computed<bool>? _$isWritingComputed;

  @override
  bool get isWriting => (_$isWritingComputed ??= Computed<bool>(
    () => super.isWriting,
    name: 'InputFormStoreBase.isWriting',
  )).value;
  Computed<File?>? _$fileComputed;

  @override
  File? get file => (_$fileComputed ??= Computed<File?>(
    () => super.file,
    name: 'InputFormStoreBase.file',
  )).value;
  Computed<Stream<List<Message>>>? _$messagesComputed;

  @override
  Stream<List<Message>> get messages =>
      (_$messagesComputed ??= Computed<Stream<List<Message>>>(
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

  late final _$_formDataAtom = Atom(
    name: 'InputFormStoreBase._formData',
    context: context,
  );

  @override
  ObservableMap<String, dynamic> get _formData {
    _$_formDataAtom.reportRead();
    return super._formData;
  }

  @override
  set _formData(ObservableMap<String, dynamic> value) {
    _$_formDataAtom.reportWrite(value, super._formData, () {
      super._formData = value;
    });
  }

  late final _$_fileAtom = Atom(
    name: 'InputFormStoreBase._file',
    context: context,
  );

  @override
  File? get _file {
    _$_fileAtom.reportRead();
    return super._file;
  }

  @override
  set _file(File? value) {
    _$_fileAtom.reportWrite(value, super._file, () {
      super._file = value;
    });
  }

  late final _$_messagesAtom = Atom(
    name: 'InputFormStoreBase._messages',
    context: context,
  );

  @override
  ObservableStream<List<Message>> get _messages {
    _$_messagesAtom.reportRead();
    return super._messages;
  }

  @override
  set _messages(ObservableStream<List<Message>> value) {
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
formData: ${formData},
isWriting: ${isWriting},
file: ${file},
messages: ${messages}
    ''';
  }
}
