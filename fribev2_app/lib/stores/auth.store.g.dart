// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  Computed<AppUser?>? _$currentUserComputed;

  @override
  AppUser? get currentUser => (_$currentUserComputed ??= Computed<AppUser?>(
    () => super.currentUser,
    name: 'AuthStoreBase.currentUser',
  )).value;
  Computed<Stream<AppUser?>>? _$userChangesComputed;

  @override
  Stream<AppUser?> get userChanges =>
      (_$userChangesComputed ??= Computed<Stream<AppUser?>>(
        () => super.userChanges,
        name: 'AuthStoreBase.userChanges',
      )).value;

  late final _$_currentUserAtom = Atom(
    name: 'AuthStoreBase._currentUser',
    context: context,
  );

  @override
  ObservableStream<AppUser?> get _currentUser {
    _$_currentUserAtom.reportRead();
    return super._currentUser;
  }

  @override
  set _currentUser(ObservableStream<AppUser?> value) {
    _$_currentUserAtom.reportWrite(value, super._currentUser, () {
      super._currentUser = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    'AuthStoreBase.login',
    context: context,
  );

  @override
  Future<void> login({required String email, required String password}) {
    return _$loginAsyncAction.run(
      () => super.login(email: email, password: password),
    );
  }

  late final _$signupAsyncAction = AsyncAction(
    'AuthStoreBase.signup',
    context: context,
  );

  @override
  Future<void> signup({required String email, required String password}) {
    return _$signupAsyncAction.run(
      () => super.signup(email: email, password: password),
    );
  }

  late final _$logoutAsyncAction = AsyncAction(
    'AuthStoreBase.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$AuthStoreBaseActionController = ActionController(
    name: 'AuthStoreBase',
    context: context,
  );

  @override
  Stream<AppUser?> fetchCurrentUser() {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
      name: 'AuthStoreBase.fetchCurrentUser',
    );
    try {
      return super.fetchCurrentUser();
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
userChanges: ${userChanges}
    ''';
  }
}
