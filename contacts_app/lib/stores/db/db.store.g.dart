// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DbStore on DbStoreBase, Store {
  Computed<List<Contact>>? _$contactsListComputed;

  @override
  List<Contact> get contactsList =>
      (_$contactsListComputed ??= Computed<List<Contact>>(
        () => super.contactsList,
        name: 'DbStoreBase.contactsList',
      )).value;
  Computed<FutureStatus>? _$statusComputed;

  @override
  FutureStatus get status => (_$statusComputed ??= Computed<FutureStatus>(
    () => super.status,
    name: 'DbStoreBase.status',
  )).value;

  late final _$_contactsFutureAtom = Atom(
    name: 'DbStoreBase._contactsFuture',
    context: context,
  );

  @override
  ObservableFuture<List<Contact>> get _contactsFuture {
    _$_contactsFutureAtom.reportRead();
    return super._contactsFuture;
  }

  @override
  set _contactsFuture(ObservableFuture<List<Contact>> value) {
    _$_contactsFutureAtom.reportWrite(value, super._contactsFuture, () {
      super._contactsFuture = value;
    });
  }

  late final _$_contactsAtom = Atom(
    name: 'DbStoreBase._contacts',
    context: context,
  );

  @override
  ObservableList<Contact> get _contacts {
    _$_contactsAtom.reportRead();
    return super._contacts;
  }

  @override
  set _contacts(ObservableList<Contact> value) {
    _$_contactsAtom.reportWrite(value, super._contacts, () {
      super._contacts = value;
    });
  }

  late final _$_fetchContactsAsyncAction = AsyncAction(
    'DbStoreBase._fetchContacts',
    context: context,
  );

  @override
  Future<void> _fetchContacts() {
    return _$_fetchContactsAsyncAction.run(() => super._fetchContacts());
  }

  late final _$addContactAsyncAction = AsyncAction(
    'DbStoreBase.addContact',
    context: context,
  );

  @override
  Future<void> addContact(Contact contact) {
    return _$addContactAsyncAction.run(() => super.addContact(contact));
  }

  late final _$initAsyncAction = AsyncAction(
    'DbStoreBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$disposeAsyncAction = AsyncAction(
    'DbStoreBase.dispose',
    context: context,
  );

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  @override
  String toString() {
    return '''
contactsList: ${contactsList},
status: ${status}
    ''';
  }
}
