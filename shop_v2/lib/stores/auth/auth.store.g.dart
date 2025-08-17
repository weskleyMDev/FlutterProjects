// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  Computed<ObservableStream<AppUser?>>? _$userChangesComputed;

  @override
  ObservableStream<AppUser?> get userChanges =>
      (_$userChangesComputed ??= Computed<ObservableStream<AppUser?>>(
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

  late final _$_currentUserAtom = Atom(
    name: 'AuthStoreBase._currentUser',
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

  late final _$signOutUserAsyncAction = AsyncAction(
    'AuthStoreBase.signOutUser',
    context: context,
  );

  @override
  Future<void> signOutUser() {
    return _$signOutUserAsyncAction.run(() => super.signOutUser());
  }

  late final _$initUserAsyncAction = AsyncAction(
    'AuthStoreBase.initUser',
    context: context,
  );

  @override
  Future<void> initUser() {
    return _$initUserAsyncAction.run(() => super.initUser());
  }

  @override
  String toString() {
    return '''
userChanges: ${userChanges},
currentUser: ${currentUser}
    ''';
  }
}
