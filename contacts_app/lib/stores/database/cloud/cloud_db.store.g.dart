// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_db.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CloudDbStore on CloudDbStoreBase, Store {
  Computed<List<Contact>>? _$contactsListComputed;

  @override
  List<Contact> get contactsList =>
      (_$contactsListComputed ??= Computed<List<Contact>>(
        () => super.contactsList,
        name: 'CloudDbStoreBase.contactsList',
      )).value;
  Computed<FutureStatus>? _$statusComputed;

  @override
  FutureStatus get status => (_$statusComputed ??= Computed<FutureStatus>(
    () => super.status,
    name: 'CloudDbStoreBase.status',
  )).value;

  late final _$_contactsStreamAtom = Atom(
    name: 'CloudDbStoreBase._contactsStream',
    context: context,
  );

  @override
  ObservableStream<List<Contact>> get _contactsStream {
    _$_contactsStreamAtom.reportRead();
    return super._contactsStream;
  }

  @override
  set _contactsStream(ObservableStream<List<Contact>> value) {
    _$_contactsStreamAtom.reportWrite(value, super._contactsStream, () {
      super._contactsStream = value;
    });
  }

  late final _$_contactsFutureAtom = Atom(
    name: 'CloudDbStoreBase._contactsFuture',
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
    name: 'CloudDbStoreBase._contacts',
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
    'CloudDbStoreBase._fetchContacts',
    context: context,
  );

  @override
  Future<void> _fetchContacts() {
    return _$_fetchContactsAsyncAction.run(() => super._fetchContacts());
  }

  late final _$_addContactAsyncAction = AsyncAction(
    'CloudDbStoreBase._addContact',
    context: context,
  );

  @override
  Future<void> _addContact(Contact contact) {
    return _$_addContactAsyncAction.run(() => super._addContact(contact));
  }

  late final _$_updateContactAsyncAction = AsyncAction(
    'CloudDbStoreBase._updateContact',
    context: context,
  );

  @override
  Future<void> _updateContact(Contact contact) {
    return _$_updateContactAsyncAction.run(() => super._updateContact(contact));
  }

  late final _$deleteContactAsyncAction = AsyncAction(
    'CloudDbStoreBase.deleteContact',
    context: context,
  );

  @override
  Future<void> deleteContact({required String id}) {
    return _$deleteContactAsyncAction.run(() => super.deleteContact(id: id));
  }

  late final _$saveContactAsyncAction = AsyncAction(
    'CloudDbStoreBase.saveContact',
    context: context,
  );

  @override
  Future<void> saveContact(Map<String, dynamic> data) {
    return _$saveContactAsyncAction.run(() => super.saveContact(data));
  }

  late final _$initAsyncAction = AsyncAction(
    'CloudDbStoreBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
contactsList: ${contactsList},
status: ${status}
    ''';
  }
}
