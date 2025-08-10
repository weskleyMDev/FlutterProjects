import 'package:mobx/mobx.dart';
import 'package:shop_v2/services/auth/iauth_service.dart';

part 'auth_form.store.g.dart';

class AuthFormStore = AuthFormStoreBase with _$AuthFormStore;

abstract class AuthFormStoreBase with Store {
  AuthFormStoreBase({required IAuthService authService})
    : _authService = authService;
  final IAuthService _authService;

  @observable
  ObservableMap<String, dynamic> _authFormData = ObservableMap();

  @observable
  bool _isLoading = false;

  @computed
  ObservableMap<String, dynamic> get authFormData => _authFormData;

  @computed
  bool get isLoading => _isLoading;

  set authFormData(ObservableMap<String, dynamic> value) {
    _authFormData = value;
  }

  @action
  void toggleLoading() {
    _isLoading = !_isLoading;
  }

  @action
  Future<void> registerUser() async {
    try {
      await _authService.signUp(data: _authFormData);
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> loginUser() async {
    try {
      await _authService.signIn(data: _authFormData);
    } catch (e) {
      rethrow;
    }
  }

  @action
  void dispose() {
    _authFormData.clear();
  }
}
