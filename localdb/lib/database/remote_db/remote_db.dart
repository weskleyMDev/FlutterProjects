import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localdb/models/todo_model.dart';

final class RemoteDb {
  final _firestore = FirebaseFirestore.instance;
  static const String _collection = 'todos';

  Future<void> addTodo(TodoModel todo) async {
    _firestore
        .collection(_collection)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _firestore
        .collection(_collection)
        .doc(todo.id)
        .update(todo.toFirestore());
  }

  Future<void> deleteTodo(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  Future<List<TodoModel>> fetchTodos() async {
    final querySnapshot = await _firestore
        .collection(_collection)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<List<TodoModel>> streamTodos() {
    return _firestore
        .collection(_collection)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
  }

  Map<String, dynamic> _toFirestore(TodoModel todo, SetOptions? options) =>
      todo.toFirestore();

  TodoModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) => TodoModel.fromFirestore(doc.data()!);
}
