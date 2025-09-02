import 'dart:async';

import 'package:admin_shop/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'iuser_repository.dart';

final class UserRepository implements IUserRepository {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>?> _getUsers() => _firestore
      .collection('users')
      .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .asBroadcastStream();

  Map<String, dynamic> _toFirestore(UserModel user, SetOptions? options) =>
      user.toMap();

  UserModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) return UserModel.empty();
    return UserModel.fromMap(data);
  }

  @override
  Stream<List<UserModel>?> get users => _getUsers();
}
