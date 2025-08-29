import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_bloc/models/app_user.dart';
import 'package:form_bloc/services/auth/iauth_service.dart';

final class AuthService implements IAuthService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  AppUser? _currentUser;
  late final Stream<AppUser?> _userChanges = _auth.authStateChanges().asyncMap((
    user,
  ) async {
    if (user == null) {
      _currentUser = null;
      return null;
    } else {
      return await _getUser(user);
    }
  }).asBroadcastStream();

  Future<AppUser?> _getUser(User user) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .get();
      final data = doc.data();
      if (doc.exists && data != null) {
        _currentUser = data;
        return _currentUser;
      } else {
        _currentUser = null;
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppUser?> signUp(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user != null) {
        final newUser = AppUser.local(id: user.uid, email: email);
        await _registerUser(newUser);
        _currentUser = newUser;
        return _currentUser;
      } else {
        throw Exception('Invalid user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _registerUser(AppUser user) async {
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

  Map<String, dynamic> _toFirestore(AppUser user, SetOptions? options) =>
      user.toMap();

  AppUser _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data != null) {
      return AppUser.fromMap(data);
    } else {
      throw Exception('Invalid data');
    }
  }

  @override
  Stream<AppUser?> get userChanges => _userChanges;
}
