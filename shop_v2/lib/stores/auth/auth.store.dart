import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/user/app_user.dart';
import 'package:shop_v2/services/auth/iauth_service.dart';

part 'auth.store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase({required IAuthService authService})
    : _authService = authService {
    _userChanges = ObservableStream(_authService.userChanges);
    _userChanges.listen((user) => _currentUser = user);
  }

  final IAuthService _authService;

  @observable
  ObservableStream<AppUser?> _userChanges = ObservableStream(Stream.empty());

  @observable
  AppUser? _currentUser;

  @computed
  ObservableStream<AppUser?> get userChanges => _userChanges;

  @computed
  AppUser? get currentUser => _currentUser;

  @action
  Future<void> signOutUser() async {
    await _authService.signOut();
  }

  @action
  Future<void> initUser() async {
    final user = await _authService.userChanges.first;
    _currentUser = user;
  }
}
