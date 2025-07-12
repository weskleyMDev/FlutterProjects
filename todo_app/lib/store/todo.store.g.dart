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

  late final _$openedIndexAtom = Atom(
    name: 'ToDoStoreBase.openedIndex',
    context: context,
  );

  @override
  int? get openedIndex {
    _$openedIndexAtom.reportRead();
    return super.openedIndex;
  }

  @override
  set openedIndex(int? value) {
    _$openedIndexAtom.reportWrite(value, super.openedIndex, () {
      super.openedIndex = value;
    });
  }

  late final _$ToDoStoreBaseActionController = ActionController(
    name: 'ToDoStoreBase',
    context: context,
  );

  @override
  void addTodo(ToDo? todo) {
    final _$actionInfo = _$ToDoStoreBaseActionController.startAction(
      name: 'ToDoStoreBase.addTodo',
    );
    try {
      return super.addTodo(todo);
    } finally {
      _$ToDoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTodo(ToDo? todo) {
    final _$actionInfo = _$ToDoStoreBaseActionController.startAction(
      name: 'ToDoStoreBase.removeTodo',
    );
    try {
      return super.removeTodo(todo);
    } finally {
      _$ToDoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAll() {
    final _$actionInfo = _$ToDoStoreBaseActionController.startAction(
      name: 'ToDoStoreBase.removeAll',
    );
    try {
      return super.removeAll();
    } finally {
      _$ToDoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
openedIndex: ${openedIndex},
items: ${items}
    ''';
  }
}
