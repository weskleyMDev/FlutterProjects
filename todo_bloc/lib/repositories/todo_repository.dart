import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo_model.dart';
import 'package:uuid/uuid.dart';

part 'itodo_repository.dart';

class TodoRepository implements ITodoRepository {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<TodoModel>> _fetchData() {
    return _firestore
        .collection('todos')
        .withConverter<TodoModel>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots()
        .asBroadcastStream();
  }

  Map<String, dynamic> _toFirestore(TodoModel todo, SetOptions? options) =>
      todo.toMap();

  TodoModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) return TodoModel.empty();
    return TodoModel.fromMap(data);
  }

  @override
  Future<TodoModel> addTodo(String text) async {
    final newTodo = TodoModel(id: Uuid().v4(), text: text);
    await _firestore
        .collection('todos')
        .doc(newTodo.id)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .set(newTodo);
    return newTodo;
  }

  @override
  Future<void> deleteTodoById(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }

  @override
  Stream<QuerySnapshot<TodoModel>> get todoStream => _fetchData();
}
