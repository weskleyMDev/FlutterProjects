import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seller_fribe/models/user_model.dart';

part 'iauth_service.dart';

final class AuthService implements IAuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot<UserModel>>? _userDocSubscription;
  String? _currentListeningUserId;

  @override
  Stream<UserModel?> get userChanges =>
      _auth.authStateChanges().asyncMap((user) async {
        if (user == null) return null;
        return await _getUserFromFirestore(user);
      }).asBroadcastStream();

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _userDocSubscription?.cancel();
    _userDocSubscription = null;
    await _auth.signOut();
  }

  Future<UserModel?> _getUserFromFirestore(User user) async {
    try {
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          );

      final doc = await docRef.get();
      if (doc.exists) {
        if (_currentListeningUserId != user.uid) {
          await _userDocSubscription?.cancel();
          _userDocSubscription = docRef.snapshots().listen((snapshot) {
            if (snapshot.exists && snapshot.data()?.isActive == false) {
              _auth.signOut();
            }
          });
          _currentListeningUserId = user.uid;
        }

        return doc.data();
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _toFirestore(UserModel user, SetOptions? options) =>
      user.toMap();

  UserModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception("User data is null");
    return UserModel.fromMap(data);
  }
}
