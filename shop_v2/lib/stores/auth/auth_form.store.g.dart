// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthFormStore on AuthFormStoreBase, Store {
  Computed<ObservableMap<String, dynamic>>? _$authFormdataComputed;

  @override
  ObservableMap<String, dynamic> get authFormdata =>
      (_$authFormdataComputed ??= Computed<ObservableMap<String, dynamic>>(
        () => super.authFormdata,
        name: 'AuthFormStoreBase.authFormdata',
      )).value;

  late final _$_authFormdataAtom = Atom(
    name: 'AuthFormStoreBase._authFormdata',
    context: context,
  );

  @override
  ObservableMap<String, dynamic> get _authFormdata {
    _$_authFormdataAtom.reportRead();
    return super._authFormdata;
  }

  @override
  set _authFormdata(ObservableMap<String, dynamic> value) {
    _$_authFormdataAtom.reportWrite(value, super._authFormdata, () {
      super._authFormdata = value;
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
authFormdata: ${authFormdata}
    ''';
  }
}
