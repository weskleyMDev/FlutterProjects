import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seller_fribe/models/user_model.dart';

part 'iauth_service.dart';

final class AuthService implements IAuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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
    await _auth.signOut();
  }

  Future<UserModel?> _getUserFromFirestore(User user) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .get();
      if (doc.exists) {
        _firestore.collection('users').doc(user.uid).snapshots().listen((
          snapshot,
        ) {
          if (snapshot.exists && snapshot.data()?['isActive'] == false) {
            _auth.signOut();
          }
        });
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
