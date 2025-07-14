import 'package:mobx/mobx.dart';

import '../exceptions/add_todo_exception.dart';
import '../exceptions/remove_todo_exception.dart';
import '../models/todo.dart';
import '../services/db/idatabase_service.dart';
import '../services/db/local_db_service.dart';

part 'todo.store.g.dart';

class ToDoStore = ToDoStoreBase with _$ToDoStore;

abstract class ToDoStoreBase with Store {
  final IDatabaseService db = LocalDbService();

  @observable
  ObservableList<ToDo> _items = ObservableList<ToDo>();

  @computed
  List<ToDo> get items => List.unmodifiable(_items);

  @action
  Future<void> loadTodoList() async {
    final dataList = await db.getData(table: 'todo');
    if (dataList.isEmpty) {
      _items.clear();
      return;
    }
    _items = dataList.map((t) => ToDo.fromMap(t)).toList().asObservable();
  }

  @action
  Future<void> insertTodo({required ToDo todo}) async {
    final index = _items.indexWhere((element) => element.id == todo.id);
    if (index != -1) throw AddToDoException('same_todo_id');
    await db.insertData(table: 'todo', data: todo.toMap());
    _items.add(todo);
  }

  @action
  Future<void> redoInsert({required ToDo todo}) async {
    await db.insertData(table: 'todo', data: todo.toMap());
    _items.add(todo);
  }

  @action
  Future<void> deleteTodo({required ToDo todo}) async {
    final index = _items.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      await db.deleteData(table: 'todo', id: todo.id);
      _items.removeAt(index);
    } else {
      throw RemoveToDoException('todo_not_found');
    }
  }

  @action
  Future<void> updateTodo({required ToDo todo}) async {
    final index = _items.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      await db.updateData(table: 'todo', data: todo.toMap());
      _items[index] = todo;
    }
  }

  @action
  Future<void> deleteAll() async {
    await db.clearData(table: 'todo');
    _items.clear();
  }
}
