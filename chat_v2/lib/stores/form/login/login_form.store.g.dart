// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginFormStore on LoginFormStoreBase, Store {
  Computed<Map<String, dynamic>>? _$formDataComputed;

  @override
  Map<String, dynamic> get formData =>
      (_$formDataComputed ??= Computed<Map<String, dynamic>>(
        () => super.formData,
        name: 'LoginFormStoreBase.formData',
      )).value;
  Computed<Stream<AppUser?>>? _$userChangesComputed;

  @override
  Stream<AppUser?> get userChanges =>
      (_$userChangesComputed ??= Computed<Stream<AppUser?>>(
        () => super.userChanges,
        name: 'LoginFormStoreBase.userChanges',
      )).value;
  Computed<AppUser?>? _$currentUserComputed;

  @override
  AppUser? get currentUser => (_$currentUserComputed ??= Computed<AppUser?>(
    () => super.currentUser,
    name: 'LoginFormStoreBase.currentUser',
  )).value;
  Computed<String?>? _$errorComputed;

  @override
  String? get error => (_$errorComputed ??= Computed<String?>(
    () => super.error,
    name: 'LoginFormStoreBase.error',
  )).value;
  Computed<bool>? _$isLoginComputed;

  @override
  bool get isLogin => (_$isLoginComputed ??= Computed<bool>(
    () => super.isLogin,
    name: 'LoginFormStoreBase.isLogin',
  )).value;
  Computed<bool>? _$isVisibleComputed;

  @override
  bool get isVisible => (_$isVisibleComputed ??= Computed<bool>(
    () => super.isVisible,
    name: 'LoginFormStoreBase.isVisible',
  )).value;

  late final _$_errorAtom = Atom(
    name: 'LoginFormStoreBase._error',
    context: context,
  );

  @override
  String get _error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  set _error(String value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  late final _$_isLoginAtom = Atom(
    name: 'LoginFormStoreBase._isLogin',
    context: context,
  );

  @override
  bool get _isLogin {
    _$_isLoginAtom.reportRead();
    return super._isLogin;
  }

  @override
  set _isLogin(bool value) {
    _$_isLoginAtom.reportWrite(value, super._isLogin, () {
      super._isLogin = value;
    });
  }

  late final _$_isVisibleAtom = Atom(
    name: 'LoginFormStoreBase._isVisible',
    context: context,
  );

  @override
  bool get _isVisible {
    _$_isVisibleAtom.reportRead();
    return super._isVisible;
  }

  @override
  set _isVisible(bool value) {
    _$_isVisibleAtom.reportWrite(value, super._isVisible, () {
      super._isVisible = value;
    });
  }

  late final _$_formDataAtom = Atom(
    name: 'LoginFormStoreBase._formData',
    context: context,
  );

  @override
  ObservableMap<String, dynamic> get _formData {
    _$_formDataAtom.reportRead();
    return super._formData;
  }

  @override
  set _formData(ObservableMap<String, dynamic> value) {
    _$_formDataAtom.reportWrite(value, super._formData, () {
      super._formData = value;
    });
  }

  late final _$_userChangesAtom = Atom(
    name: 'LoginFormStoreBase._userChanges',
    context: context,
  );

  @override
  ObservableStream<AppUser?> get _userChanges {
    _$_userChangesAtom.reportRead();
    return super._userChanges;
  }

  @override
  set _userChanges(ObservableStream<AppUser?> value) {
    _$_userChangesAtom.reportWrite(value, super._userChanges, () {
      super._userChanges = value;
    });
  }

  late final _$_currentUserAtom = Atom(
    name: 'LoginFormStoreBase._currentUser',
    context: context,
  );

  @override
  AppUser? get _currentUser {
    _$_currentUserAtom.reportRead();
    return super._currentUser;
  }

  @override
  set _currentUser(AppUser? value) {
    _$_currentUserAtom.reportWrite(value, super._currentUser, () {
      super._currentUser = value;
    });
  }

  late final _$setImageUrlAsyncAction = AsyncAction(
    'LoginFormStoreBase.setImageUrl',
    context: context,
  );

  @override
  Future<void> setImageUrl() {
    return _$setImageUrlAsyncAction.run(() => super.setImageUrl());
  }

  late final _$signInAsyncAction = AsyncAction(
    'LoginFormStoreBase.signIn',
    context: context,
  );

  @override
  Future<void> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  late final _$signUpAsyncAction = AsyncAction(
    'LoginFormStoreBase.signUp',
    context: context,
  );

  @override
  Future<void> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  late final _$signOutAsyncAction = AsyncAction(
    'LoginFormStoreBase.signOut',
    context: context,
  );

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$LoginFormStoreBaseActionController = ActionController(
    name: 'LoginFormStoreBase',
    context: context,
  );

  @override
  AppUser? _getCurrentUser() {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
      name: 'LoginFormStoreBase._getCurrentUser',
    );
    try {
      return super._getCurrentUser();
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleLogin() {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
      name: 'LoginFormStoreBase.toggleLogin',
    );
    try {
      return super.toggleLogin();
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleVisible() {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
      name: 'LoginFormStoreBase.toggleVisible',
    );
    try {
      return super.toggleVisible();
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Stream<AppUser?> _fetchUserChanges() {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
      name: 'LoginFormStoreBase._fetchUserChanges',
    );
    try {
      return super._fetchUserChanges();
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _clear() {
    final _$actionInfo = _$LoginFormStoreBaseActionController.startAction(
      name: 'LoginFormStoreBase._clear',
    );
    try {
      return super._clear();
    } finally {
      _$LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formData: ${formData},
userChanges: ${userChanges},
currentUser: ${currentUser},
error: ${error},
isLogin: ${isLogin},
isVisible: ${isVisible}
    ''';
  }
}
