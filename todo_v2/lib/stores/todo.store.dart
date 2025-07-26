import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';

import '../services/data/idata_service.dart';

part 'todo.store.g.dart';

class TodoStore = TodoStoreBase with _$TodoStore;

abstract class TodoStoreBase with Store {
  TodoStoreBase({required this.dataService});
  final IDataService dataService;
  // @observable
  // ObservableStream<List<Map<String, dynamic>>> _todoStream = ObservableStream(
  //   Stream.empty(),
  // );

  StreamController<List<Map<String, dynamic>>> _todoController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  @observable
  ObservableList<Map<String, dynamic>> _todoList =
      ObservableList<Map<String, dynamic>>();

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
    _todoController.add(_todoList.toList());
    //_todoStream = ObservableStream(Stream.value(_todoList));
  }

  @action
  Future<void> sortList() async {
    _todoList.sort((a, b) {
      if (a['done'] && !b['done']) {
        return 1;
      } else if (!a['done'] && b['done']) {
        return -1;
      } else {
        return 0;
      }
    });
    await _saveData();
    _todoController.add(_todoList.toList());
  }

  @action
  Future<void> removeTodo(int index) async {
    _todoList.removeAt(index);
    await _saveData();
    _todoController.add(_todoList.toList());
  }

  @action
  Future<void> rendo(int index, Map<String, dynamic> element) async {
    _todoList.insert(index, element);
    await _saveData();
    _todoController.add(_todoList.toList());
  }

  @action
  Future<void> setDoneTodo(int index, bool? value) async {
    _todoList[index]['done'] = value;
    await _saveData();
    _todoController.add(_todoList.toList());
    //final updated = Map<String, dynamic>.from(_todoList[index]);
    //updated['done'] = value ?? false;
    //_todoList[index] = updated;
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
      _todoController.add(_todoList.toList());
      //_todoStream = ObservableStream(Stream.value(_todoList));
    }
  }

  @action
  Future<File> _createData() async {
    return dataService.createData();
  }

  @action
  Future<void> _saveData() async {
    await dataService.saveData(_todoList);
  }

  @action
  Future<String?> _readData() async {
    return dataService.readData();
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
