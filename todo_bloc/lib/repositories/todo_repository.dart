import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/repositories/itodo_repository.dart';
import 'package:uuid/uuid.dart';

class TodoRepository implements ITodoRepository {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<TodoModel>> fetchData() {
    return _firestore
        .collection('todos')
        .withConverter<TodoModel>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
  }

  Map<String, dynamic> _toFirestore(TodoModel todo, SetOptions? options) =>
      todo.toMap();

  TodoModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception('Invalid data');
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
  Stream<List<TodoModel>> get todoStream => fetchData();
}
