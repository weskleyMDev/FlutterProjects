// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthFormStore on AuthFormStoreBase, Store {
  Computed<ObservableMap<String, dynamic>>? _$authFormDataComputed;

  @override
  ObservableMap<String, dynamic> get authFormData =>
      (_$authFormDataComputed ??= Computed<ObservableMap<String, dynamic>>(
        () => super.authFormData,
        name: 'AuthFormStoreBase.authFormData',
      )).value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: 'AuthFormStoreBase.isLoading',
  )).value;
  Computed<bool>? _$isVisibleComputed;

  @override
  bool get isVisible => (_$isVisibleComputed ??= Computed<bool>(
    () => super.isVisible,
    name: 'AuthFormStoreBase.isVisible',
  )).value;

  late final _$_authFormDataAtom = Atom(
    name: 'AuthFormStoreBase._authFormData',
    context: context,
  );

  @override
  ObservableMap<String, dynamic> get _authFormData {
    _$_authFormDataAtom.reportRead();
    return super._authFormData;
  }

  @override
  set _authFormData(ObservableMap<String, dynamic> value) {
    _$_authFormDataAtom.reportWrite(value, super._authFormData, () {
      super._authFormData = value;
    });
  }

  late final _$_isLoadingAtom = Atom(
    name: 'AuthFormStoreBase._isLoading',
    context: context,
  );

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_isVisibleAtom = Atom(
    name: 'AuthFormStoreBase._isVisible',
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

  late final _$registerUserAsyncAction = AsyncAction(
    'AuthFormStoreBase.registerUser',
    context: context,
  );

  @override
  Future<void> registerUser() {
    return _$registerUserAsyncAction.run(() => super.registerUser());
  }

  late final _$loginUserAsyncAction = AsyncAction(
    'AuthFormStoreBase.loginUser',
    context: context,
  );

  @override
  Future<void> loginUser() {
    return _$loginUserAsyncAction.run(() => super.loginUser());
  }

  late final _$AuthFormStoreBaseActionController = ActionController(
    name: 'AuthFormStoreBase',
    context: context,
  );

  @override
  void toggleLoading() {
    final _$actionInfo = _$AuthFormStoreBaseActionController.startAction(
      name: 'AuthFormStoreBase.toggleLoading',
    );
    try {
      return super.toggleLoading();
    } finally {
      _$AuthFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleVisibility() {
    final _$actionInfo = _$AuthFormStoreBaseActionController.startAction(
      name: 'AuthFormStoreBase.toggleVisibility',
    );
    try {
      return super.toggleVisibility();
    } finally {
      _$AuthFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$AuthFormStoreBaseActionController.startAction(
      name: 'AuthFormStoreBase.dispose',
    );
    try {
      return super.dispose();
    } finally {
      _$AuthFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authFormData: ${authFormData},
isLoading: ${isLoading},
isVisible: ${isVisible}
    ''';
  }
}
