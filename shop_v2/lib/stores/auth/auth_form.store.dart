import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
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

  @observable
  bool _isVisible = false;

  @observable
  bool _imageSelected = false;

  @computed
  ObservableMap<String, dynamic> get authFormData => _authFormData;

  @computed
  bool get isLoading => _isLoading;

  @computed
  bool get isVisible => _isVisible;

  @computed
  bool get imageSelected => _imageSelected;

  set authFormData(ObservableMap<String, dynamic> value) {
    _authFormData = value;
  }

  @action
  void toggleLoading() {
    _isLoading = !_isLoading;
  }

  @action
  void toggleVisibility() {
    _isVisible = !_isVisible;
  }

  @action
  Future<void> selectImage() async {
    try {
      if (Platform.isAndroid) {
        final imageFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );
        if (imageFile == null) return;
        final filePath = imageFile.path;
        _authFormData['imageUrl'] = filePath;
      }
      if (Platform.isWindows) {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );
        if (result == null) return;
        final filePath = result.files.first.path;
        _authFormData['imageUrl'] = filePath;
      }
      if (_authFormData['imageUrl'] != null) {
        _imageSelected = true;
      }
    } catch (e) {
      rethrow;
    }
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
