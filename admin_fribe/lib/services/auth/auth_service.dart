import 'package:admin_fribe/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'iauth_service.dart';

final class AuthService implements IAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  UserModel? _currentUser;

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) throw Exception('Invalid user credentials!');
      final newUser = UserModel.empty();
      await _registerUser(
        newUser.copyWith(
          id: () => user.uid,
          name: () => name,
          email: () => email,
          isActive: () => true,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _registerUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .set(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Stream<UserModel?> get userChanges =>
      _firebaseAuth.authStateChanges().asyncMap((user) async {
        if (user != null) {
          if (await _isAdmin(uid: user.uid)) {
            _currentUser = await _getUserFromFirebase(user);

          } else {
            await _firebaseAuth.signOut();
            throw FirebaseAuthException(
              code: 'operation-not-allowed',
              message: 'User is not an admin!',
            );
          }
        } else {
          _currentUser = null;
        }
        return _currentUser;
      }).asBroadcastStream();

  Future<UserModel?> _getUserFromFirebase(User user) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .get();
      if (!doc.exists) return null;
      return doc.data();
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
    if (data == null) {
      throw StateError('Missing data for userId: ${snapshot.id}');
    }
    return UserModel.fromMap(data);
  }

  Future<bool> _isAdmin({required String uid}) async {
    try {
      final doc = await _firestore.collection('admin').doc(uid).get();
      if (doc.data() != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
