import 'dart:convert';
import 'dart:io';

import 'package:chat_v2/models/app_user.dart';
import 'package:chat_v2/services/auth/iauth_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

part 'login_form.store.g.dart';

class LoginFormStore = LoginFormStoreBase with _$LoginFormStore;

abstract class LoginFormStoreBase with Store {
  LoginFormStoreBase({required this.authService}) {
    _userChanges = ObservableStream(authService.userChanges);
  }
  final IAuthService authService;

  // OBSERVABLES

  @observable
  String _error = '';

  @observable
  bool _isLogin = true;

  @observable
  bool _isVisible = false;

  @observable
  ObservableMap<String, dynamic> _formData = ObservableMap<String, dynamic>();

  @observable
  late ObservableStream<AppUser?> _userChanges;

  // COMPUTED

  @computed
  Map<String, dynamic> get formData => _formData;

  @computed
  Stream<AppUser?> get userChanges => _userChanges;

  @computed
  AppUser? get currentUser => _userChanges.value;

  @computed
  String get error => _error;

  @computed
  bool get isLogin => _isLogin;

  @computed
  bool get isVisible => _isVisible;

  // SETTERS

  set formData(Map<String, dynamic> value) =>
      _formData = ObservableMap<String, dynamic>.of(value);

  // ACTIONS

  @action
  Future<void> _uploadImage(String imagePath) async {
    _error = '';
    try {
      final uri = Uri.https('api.cloudinary.com', '/v1_1/dcfabcpnx/upload');
      final uploadRequest = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'dcfabcpnx'
        ..files.add(await http.MultipartFile.fromPath('file', imagePath));

      final response = await uploadRequest.send();
      if (response.statusCode >= 400) {
        _error = 'Error ${response.statusCode} uploading image';
      } else {
        final responseBody = await response.stream.bytesToString();
        final jsonMap = json.decode(responseBody);
        final imageUrl = jsonMap['secure_url'];
        _formData['imageUrl'] = imageUrl;
      }
    } catch (e) {
      _error = 'Error uploading image: $e';
      rethrow;
    }
  }

  @action
  Future<void> setImageUrl() async {
    try {
      if (Platform.isWindows) {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );
        if (result == null) return;
        final filePath = result.files.first.path;
        if (filePath == null) return;
        await _uploadImage(filePath);
      }
    } catch (e) {
      _error = 'Error picking image: $e';
      rethrow;
    }
  }

  @action
  Future<void> signIn() async {
    _error = '';
    try {
      await authService.signIn(
        mail: _formData['email'],
        password: _formData['password'],
      );
      _clear();
    } catch (e) {
      _error = 'Email or password incorrect!';
      rethrow;
    }
  }

  @action
  Future<void> signUp() async {
    _error = '';
    try {
      await authService.signUp(
        name: _formData['name'],
        email: _formData['email'],
        imageUrl: _formData['imageUrl'],
        password: _formData['password'],
      );
      _clear();
    } catch (e) {
      _error = 'Error registering user! Check all fields!';
      rethrow;
    }
  }

  @action
  Future<void> signOut() async {
    _error = '';
    try {
      await authService.signOut();
      _clear();
    } catch (e) {
      _error = 'Error signing out!';
      rethrow;
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
  void _clear() {
    _formData.clear();
    _isLogin = true;
    _isVisible = false;
  }
}
