// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ToDoStore on ToDoStoreBase, Store {
  Computed<List<ToDo>>? _$itemsComputed;

  @override
  List<ToDo> get items => (_$itemsComputed ??= Computed<List<ToDo>>(
    () => super.items,
    name: 'ToDoStoreBase.items',
  )).value;

  late final _$_itemsAtom = Atom(
    name: 'ToDoStoreBase._items',
    context: context,
  );

  @override
  ObservableList<ToDo> get _items {
    _$_itemsAtom.reportRead();
    return super._items;
  }

  @override
  set _items(ObservableList<ToDo> value) {
    _$_itemsAtom.reportWrite(value, super._items, () {
      super._items = value;
    });
  }

  late final _$loadTodoListAsyncAction = AsyncAction(
    'ToDoStoreBase.loadTodoList',
    context: context,
  );

  @override
  Future<void> loadTodoList() {
    return _$loadTodoListAsyncAction.run(() => super.loadTodoList());
  }

  late final _$insertTodoAsyncAction = AsyncAction(
    'ToDoStoreBase.insertTodo',
    context: context,
  );

  @override
  Future<void> insertTodo({required ToDo todo}) {
    return _$insertTodoAsyncAction.run(() => super.insertTodo(todo: todo));
  }

  late final _$redoInsertAsyncAction = AsyncAction(
    'ToDoStoreBase.redoInsert',
    context: context,
  );

  @override
  Future<void> redoInsert({required ToDo todo}) {
    return _$redoInsertAsyncAction.run(() => super.redoInsert(todo: todo));
  }

  late final _$deleteTodoAsyncAction = AsyncAction(
    'ToDoStoreBase.deleteTodo',
    context: context,
  );

  @override
  Future<void> deleteTodo({required ToDo todo}) {
    return _$deleteTodoAsyncAction.run(() => super.deleteTodo(todo: todo));
  }

  late final _$updateTodoAsyncAction = AsyncAction(
    'ToDoStoreBase.updateTodo',
    context: context,
  );

  @override
  Future<void> updateTodo({required ToDo todo}) {
    return _$updateTodoAsyncAction.run(() => super.updateTodo(todo: todo));
  }

  late final _$deleteAllAsyncAction = AsyncAction(
    'ToDoStoreBase.deleteAll',
    context: context,
  );

  @override
  Future<void> deleteAll() {
    return _$deleteAllAsyncAction.run(() => super.deleteAll());
  }

  @override
  String toString() {
    return '''
items: ${items}
    ''';
  }
}
