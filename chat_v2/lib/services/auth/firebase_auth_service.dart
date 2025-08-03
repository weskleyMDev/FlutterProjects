import 'package:chat_v2/models/app_user.dart';
import 'package:chat_v2/services/auth/iauth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseAuthService implements IAuthService {
  static final _firebaseAuth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static AppUser? _currentUser;
  static final Stream<AppUser?> _userChanges = Stream.multi((controller) {
    _firebaseAuth.authStateChanges().listen(
      (user) async {
        if (user != null) {
          try {
            await _fetchUser(user);
            controller.add(_currentUser);
          } catch (e) {
            controller.addError(e);
          }
        } else {
          controller.add(null);
        }
      },
      onError: (error) {
        controller.addError(error);
      },
    );
  });

  static Future<AppUser?> _fetchUser(User? user) async {
    try {
      final doc = await _firestore.collection('users').doc(user?.uid).get();
      if (doc.exists) {
        final appUser = AppUser.fromMap(doc.data()!);
        _currentUser = appUser;
        return appUser;
      } else {
        _currentUser = null;
        return null;
      }
    } catch (e) {
      _currentUser = null;
      return null;
    }
  }

  @override
  AppUser? get currentUser => _currentUser;

  Future<void> _registerUser(AppUser appUser) async {
    try {
      await _firestore.collection('users').doc(appUser.id).set(appUser.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signIn({required String mail, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String imageUrl,
    required String password,
  }) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) return;
      final newUser = AppUser(
        id: Uuid().v4(),
        name: name,
        email: email,
        imageUrl: imageUrl,
        role: 'user',
      );
      await _registerUser(newUser);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<AppUser?> get userChanges => _userChanges;
}
