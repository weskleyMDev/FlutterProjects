import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_v2/models/user/app_user.dart';
import 'package:shop_v2/services/auth/iauth_service.dart';

class FirebaseService implements IAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  AppUser? _currentUser;
  late final Stream<AppUser?> _userChanges = _firebaseAuth
      .authStateChanges()
      .asyncMap((user) => user != null ? _getUser(user) : null)
      .asBroadcastStream();

  Future<AppUser?> _getUser(User user) async {
    try {
      final docRef = await _firestore.collection('users').doc(user.uid).get();
      if (docRef.exists) {
        _currentUser = AppUser.fromMap(docRef.data() as Map<String, dynamic>);
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
  Stream<AppUser?> get userChanges => _userChanges;

  @override
  Future<void> signIn({required Map<String, dynamic> data}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _registerUser(AppUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUp({required Map<String, dynamic> data}) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      final user = cred.user;
      if (user != null) {
        final newUser = AppUser.fromMap(data).copyWith(id: user.uid);
        await _registerUser(newUser);
        _currentUser = newUser;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _currentUser = null;
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
