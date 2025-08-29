import 'package:form_bloc/models/app_user.dart';

abstract interface class IAuthService {
  AppUser? get currentUser;
  Stream<AppUser?> get userChanges;
  Future<AppUser?> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}
