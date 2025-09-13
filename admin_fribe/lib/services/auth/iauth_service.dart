part of 'auth_service.dart';

abstract interface class IAuthService {
  Stream<UserModel?> get userChanges;
  UserModel? get currentUser;
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
}
