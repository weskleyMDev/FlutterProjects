// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on TodoStoreBase, Store {
  Computed<ObservableStream<List<Map<String, dynamic>>>>? _$todoStreamComputed;

  @override
  ObservableStream<List<Map<String, dynamic>>> get todoStream =>
      (_$todoStreamComputed ??=
              Computed<ObservableStream<List<Map<String, dynamic>>>>(
                () => super.todoStream,
                name: 'TodoStoreBase.todoStream',
              ))
          .value;

  late final _$_todoListAtom = Atom(
    name: 'TodoStoreBase._todoList',
    context: context,
  );

  @override
  ObservableList<Map<String, dynamic>> get _todoList {
    _$_todoListAtom.reportRead();
    return super._todoList;
  }

  bool __todoListIsInitialized = false;

  @override
  set _todoList(ObservableList<Map<String, dynamic>> value) {
    _$_todoListAtom.reportWrite(
      value,
      __todoListIsInitialized ? super._todoList : null,
      () {
        super._todoList = value;
        __todoListIsInitialized = true;
      },
    );
  }

  late final _$_titleAtom = Atom(
    name: 'TodoStoreBase._title',
    context: context,
  );

  @override
  String get _title {
    _$_titleAtom.reportRead();
    return super._title;
  }

  @override
  set _title(String value) {
    _$_titleAtom.reportWrite(value, super._title, () {
      super._title = value;
    });
  }

  late final _$_readListAsyncAction = AsyncAction(
    'TodoStoreBase._readList',
    context: context,
  );

  @override
  Future<void> _readList() {
    return _$_readListAsyncAction.run(() => super._readList());
  }

  late final _$_createDataAsyncAction = AsyncAction(
    'TodoStoreBase._createData',
    context: context,
  );

  @override
  Future<File> _createData() {
    return _$_createDataAsyncAction.run(() => super._createData());
  }

  late final _$_saveDataAsyncAction = AsyncAction(
    'TodoStoreBase._saveData',
    context: context,
  );

  @override
  Future<void> _saveData() {
    return _$_saveDataAsyncAction.run(() => super._saveData());
  }

  late final _$_readDataAsyncAction = AsyncAction(
    'TodoStoreBase._readData',
    context: context,
  );

  @override
  Future<String?> _readData() {
    return _$_readDataAsyncAction.run(() => super._readData());
  }

  late final _$initAsyncAction = AsyncAction(
    'TodoStoreBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$TodoStoreBaseActionController = ActionController(
    name: 'TodoStoreBase',
    context: context,
  );

  @override
  void addTodo() {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase.addTodo',
    );
    try {
      return super.addTodo();
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTodo(int index) {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase.removeTodo',
    );
    try {
      return super.removeTodo(index);
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void rendo(int index, Map<String, dynamic> element) {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase.rendo',
    );
    try {
      return super.rendo(index, element);
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDoneTodo(int index, bool? value) {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase.setDoneTodo',
    );
    try {
      return super.setDoneTodo(index, value);
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String value) {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase.setTitle',
    );
    try {
      return super.setTitle(value);
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _clearFields() {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase._clearFields',
    );
    try {
      return super._clearFields();
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$TodoStoreBaseActionController.startAction(
      name: 'TodoStoreBase.dispose',
    );
    try {
      return super.dispose();
    } finally {
      _$TodoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todoStream: ${todoStream}
    ''';
  }
}
