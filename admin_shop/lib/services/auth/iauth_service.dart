import 'package:admin_shop/models/user_model.dart';

abstract interface class IAuthService {
  UserModel? get currentUser;
  Stream<UserModel?> get userChanges;
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();
}
