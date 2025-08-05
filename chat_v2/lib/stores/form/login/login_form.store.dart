import 'dart:io';

import 'package:chat_v2/models/app_user.dart';
import 'package:chat_v2/services/auth/iauth_service.dart';
import 'package:file_picker/file_picker.dart';
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
  ObservableStream<AppUser?> _userChanges = ObservableStream(
    Stream<AppUser?>.empty(),
  );

  @observable
  AppUser? _currentUser;

  @computed
  Map<String, dynamic> get formData => _formData;

  @computed
  Stream<AppUser?> get userChanges => _fetchUserChanges();

  @computed
  AppUser? get currentUser => _getCurrentUser();

  @computed
  String? get error => _error;

  @computed
  bool get isLogin => _isLogin;

  @computed
  bool get isVisible => _isVisible;

  set formData(Map<String, dynamic> value) =>
      _formData = ObservableMap<String, dynamic>.of(value);

  @action
  Future<void> setImageUrl() async {
    if (Platform.isWindows) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result == null) return;
      final filePath = result.files.first.path;
      if (filePath == null) return;
      _formData['imageUrl'] = filePath;
    }
  }

  @action
  AppUser? _getCurrentUser() {
    return _currentUser = authService.currentUser;
  }

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
    final String? imageUrl;
    if (_formData['imageUrl'] == null) {
      imageUrl = null;
    } else {
      imageUrl = _formData['imageUrl'];
    }
    try {
      await authService.signUp(
        name: _formData['name'],
        email: _formData['email'],
        imageUrl: imageUrl,
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
  void toggleLogin() {
    _isLogin = !_isLogin;
  }

  @action
  void toggleVisible() {
    _isVisible = !_isVisible;
  }

  @action
  Stream<AppUser?> _fetchUserChanges() {
    return _userChanges = ObservableStream<AppUser?>(authService.userChanges);
  }

  @action
  void _clear() {
    _formData.clear();
    _isLogin = true;
    _isVisible = false;
  }
}
