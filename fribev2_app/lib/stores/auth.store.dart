import 'package:mobx/mobx.dart';

import '../../models/app_user.dart';
import '../../services/auth/iauth_service.dart';
part 'auth.store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase({required this.authService});
  final IAuthService authService;

  @observable
  ObservableStream<AppUser?> _currentUser = ObservableStream(
    Stream<AppUser?>.empty(),
  );

  @computed
  AppUser? get currentUser => authService.currentUser;

  @computed
  Stream<AppUser?> get userChanges => fetchCurrentUser();

  @action
  Stream<AppUser?> fetchCurrentUser() {
    return _currentUser = ObservableStream(authService.userChanges);
  }

  @action
  Future<void> login({required String email, required String password}) async {
    await authService.login(email: email, password: password);
  }

  @action
  Future<void> signup({required String email, required String password}) async {
    await authService.signup(email: email, password: password);
  }

  @action
  Future<void> logout() async {
    await authService.logout();
  }
}
