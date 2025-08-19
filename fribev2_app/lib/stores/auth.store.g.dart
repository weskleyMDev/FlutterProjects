// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  Computed<Stream<AppUser?>>? _$userChangesComputed;

  @override
  Stream<AppUser?> get userChanges =>
      (_$userChangesComputed ??= Computed<Stream<AppUser?>>(
        () => super.userChanges,
        name: 'AuthStoreBase.userChanges',
      )).value;
  Computed<AppUser?>? _$currentUserComputed;

  @override
  AppUser? get currentUser => (_$currentUserComputed ??= Computed<AppUser?>(
    () => super.currentUser,
    name: 'AuthStoreBase.currentUser',
  )).value;

  late final _$_userChangesAtom = Atom(
    name: 'AuthStoreBase._userChanges',
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

  @override
  String toString() {
    return '''
userChanges: ${userChanges},
currentUser: ${currentUser}
    ''';
  }
}
