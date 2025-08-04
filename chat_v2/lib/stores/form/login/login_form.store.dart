import 'package:chat_v2/models/app_user.dart';
import 'package:chat_v2/services/auth/iauth_service.dart';
import 'package:mobx/mobx.dart';

part 'login_form.store.g.dart';

class LoginFormStore = LoginFormStoreBase with _$LoginFormStore;

abstract class LoginFormStoreBase with Store {
  LoginFormStoreBase({required this.authService});
  final IAuthService authService;

  @observable
  String _error = '';

  @observable
  bool _isLogin = true;

  @observable
  bool _isVisible = false;


  @observable
  ObservableMap<String, dynamic> _formData = ObservableMap<String, dynamic>();

  @observable
  ObservableStream<AppUser?> _userChanges = ObservableStream<AppUser>(
    Stream.empty(),
  );

  @computed
  Map<String, dynamic> get formData => _formData;

  @computed
  Stream<AppUser?> get userChanges => _userChanges;

  @computed
  String? get error => _error;

  @computed
  bool get isLogin => _isLogin;

  @computed
  bool get isVisible => _isVisible;

  set formData(Map<String, dynamic> value) =>
      _formData = ObservableMap<String, dynamic>.of(value);

  @action
  Future<void> signIn() async {
    try {
      await authService.signIn(
        mail: _formData['email'],
        password: _formData['password'],
      );
      _clear();
    } catch (e) {
      _error = e.toString();
    }
  }

  @action
  Future<void> signUp() async {
    try {
      await authService.signUp(
        name: _formData['name'],
        email: _formData['email'],
        imageUrl: _formData['imageUrl'],
        password: _formData['password'],
      );
      _clear();
    } catch (e) {
      _error = e.toString();
    }
  }

  @action
  Future<void> signOut() async {
    try {
      await authService.signOut();
      _clear();
    } catch (e) {
      _error = e.toString();
    }
  }

  @action
  void toogleLogin() {
    _isLogin = !_isLogin;
  }

  @action
  void toogleVisible() {
    _isVisible = !_isVisible;
  }

  @action
  Future<void> init() async {
    _userChanges = ObservableStream<AppUser?>(authService.userChanges);
  }

  @action
  void _clear() {
    _error = '';
    _formData.clear();
  }
}
