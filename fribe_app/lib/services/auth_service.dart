import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signup({
    required String name,
    required String password,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: name.trim(),
            password: password.trim(),
          );

      String userId = userCredential.user!.uid;

      await _firestore.collection('users').doc(userId).set({
        'name': name.trim(),
        'role': role,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login({
    required String name,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
            email: name.trim(),
            password: password.trim(),
          );

      String userId = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      return userDoc['role'];
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getUserRole() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      return userDoc['role'];
    }
    return null;
  }

  Future<String?> updatePasswordByName({
    required String name,
    required String newPassword,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user == null || user.email != name.trim()) {
        return "Usuário não autenticado ou email não encontrado.";
      }

      await user.updatePassword(newPassword.trim());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
