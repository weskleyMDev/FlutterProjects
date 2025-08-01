import 'dart:async';

import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/backups/ibackup_service.dart';
import 'package:contacts_app/services/databases/local/ilocal_db_service.dart';
import 'package:contacts_app/utils/binary_search.dart';
import 'package:mobx/mobx.dart';

part 'local_db.store.g.dart';

class LocalDbStore = LocalDbStoreBase with _$LocalDbStore;

abstract class LocalDbStoreBase with Store {
  LocalDbStoreBase({required this.localDbService, required this.backupService});

  final ILocalDbService localDbService;
  final IBackupService backupService;

  @observable
  ObservableFuture<List<Contact>> _contactsFuture = ObservableFuture.value([]);

  @observable
  ObservableList<Contact> _contacts = ObservableList<Contact>();

  @computed
  List<Contact> get contactsList => _contacts;

  @computed
  FutureStatus get status => _contactsFuture.status;

  @action
  Future<void> _fetchContacts() async {
    _contactsFuture = ObservableFuture(localDbService.getAllContacts());
    final data = await _contactsFuture;
    _contacts = ObservableList<Contact>.of(data);
  }

  @action
  Future<void> _addContact(Contact contact) async {
    final toJson = _contacts.map((e) => e.toMap()).toList();
    await localDbService.saveContact(contact: contact);
    await backupService.saveBackup(toJson);
  }

  @action
  Future<void> _updateContact(Contact contact) async {
    final toJson = _contacts.map((e) => e.toMap()).toList();
    await localDbService.updateContact(contact: contact);
    await backupService.saveBackup(toJson);
  }

  @action
  Future<void> saveContact(Map<String, dynamic> data) async {
    final Contact newContact = Contact.fromMap(data);
    final sortedContacts = List<Contact>.from(_contacts);
    sortedContacts.sort((a, b) => a.id.compareTo(b.id));
    final index = myBinarySearch(
      sortedContacts,
      newContact,
      (a, b) => a.id.compareTo(b.id),
    );
    if (index >= 0) {
      _contacts.replaceRange(index, index + 1, [newContact]);
      await _updateContact(newContact);
    } else {
      _contacts.add(newContact);
      await _addContact(newContact);
    }
    await _fetchContacts();
  }

  @action
  Future<void> init() async {
    await localDbService.db;
    await _fetchContacts();
  }

  @action
  Future<void> dispose() async {
    await localDbService.closeDb();
    _contacts.clear();
    _contactsFuture.value?.clear();
  }
}
