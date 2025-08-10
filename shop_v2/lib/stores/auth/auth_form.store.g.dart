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
authFormData: ${authFormData}
    ''';
  }
}
