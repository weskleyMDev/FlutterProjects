import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'todo.store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  // @observable
  // ObservableStream<List<Map<String, dynamic>>> _todoStream = ObservableStream(
  //   Stream.empty(),
  // );

  StreamController<List<Map<String, dynamic>>> _todoController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  @observable
  late ObservableList<Map<String, dynamic>> _todoList;

  @observable
  String _title = '';

  @computed
  ObservableStream<List<Map<String, dynamic>>> get todoStream =>
      _todoController.stream.asObservable();

  @action
  void addTodo() {
    final newTodo = <String, dynamic>{};
    newTodo['title'] = _title;
    newTodo['done'] = false;
    _todoList.insert(0, newTodo);
    _saveData();
    _clearFields();
      _todoController.add(_todoList);
  }

  @action
  void setDoneTodo(int index, bool? value) {
    final updated = Map<String, dynamic>.from(_todoList[index]);
    updated['done'] = value ?? false;
    _todoList[index] = updated;
    _saveData();
      _todoController.add(_todoList);
    //_todoStream = ObservableStream(Stream.value(_todoList));
  }

  @action
  void setTitle(String value) => _title = value;

  @action
  void _clearFields() {
    _title = '';
  }

  @action
  Future<void> _readList() async {
    final list = await _readData();
    if (list != null) {
      List<dynamic> decodedList = jsonDecode(list);
      _todoList = ObservableList.of(
        decodedList.map((item) => Map<String, dynamic>.from(item)),
      );
        _todoController.add(_todoList);
      //_todoStream = ObservableStream(Stream.value(_todoList));
    }
  }

  @action
  Future<File> _fetchData() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  @action
  Future<void> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _fetchData();
    await file.writeAsString(data);
  }

  @action
  Future<String?> _readData() async {
    try {
      final file = await _fetchData();
      String data = await file.readAsString();
      return data;
    } catch (e) {
      return null;
    }
  }

  @action
  Future<void> init() async {
    if (_todoController.isClosed) {
      _todoController =
          StreamController<List<Map<String, dynamic>>>.broadcast();
    }
    await _readList();
  }

  @action
  void dispose() {
    _clearFields();
    if (!_todoController.isClosed) {
      _todoController.close();
    }
  }
}
