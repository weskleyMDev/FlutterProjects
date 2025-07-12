import 'package:mobx/mobx.dart';

import '../exceptions/add_todo_exception.dart';
import '../exceptions/remove_todo_exception.dart';
import '../models/todo.dart';

part 'todo.store.g.dart';

class ToDoStore = ToDoStoreBase with _$ToDoStore;

abstract class ToDoStoreBase with Store {
  @observable
  ObservableList<ToDo> _items = ObservableList<ToDo>();

  @computed
  List<ToDo> get items => List.unmodifiable(_items);

  @action
  void addTodo(ToDo? todo) {
    try {
      if (todo == null) {
        throw AddToDoException('null_todo');
      }
      _items.add(todo);
    } catch (e) {
      rethrow;
    }
  }

  @action
  void redoAdd(ToDo? todo, int? index) {
    try {
      if (todo == null || index == null) {
        throw AddToDoException('null_todo');
      }
      _items.insert(index, todo);
    } catch (e) {
      rethrow;
    }
  }

  @action
  void removeTodo(ToDo? todo) {
    try {
      if (todo == null) {
        throw RemoveToDoException('null_todo');
      }
      final index = _items.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _items.removeAt(index);
      } else {
        throw RemoveToDoException('todo_not_found');
      }
    } catch (e) {
      rethrow;
    }
  }

  @action
  void removeAll() => _items.clear();
}
