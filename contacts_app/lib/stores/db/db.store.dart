import 'package:contacts_app/services/db/cloud/icloud_db_service.dart';
import 'package:mobx/mobx.dart';

import '../../models/contact.dart';
import '../../services/db/local/ilocal_db_service.dart';

part 'db.store.g.dart';

class DbStore = DbStoreBase with _$DbStore;

abstract class DbStoreBase with Store {
  DbStoreBase({required this.localService, required this.cloudService});

  final ILocalDbService localService;
  final ICloudDbService cloudService;

  @observable
  ObservableFuture<List<Contact>> _contactsFuture = ObservableFuture.value([]);

  @observable
  ObservableList<Contact> _contacts = ObservableList<Contact>();

  @computed
  List<Contact> get contactsList => _contacts;

  @computed
  FutureStatus get status => _contactsFuture.status;

  @action
  Future<List<Contact>> _fetchContacts() async {
    _contactsFuture = ObservableFuture(localService.getAllContacts());
    final data = await _contactsFuture;
    _contacts
      ..clear()
      ..addAll(data);
    return _contacts;
  }

  @action
  Future<void> addContact(Contact contact) async {
    final newContact = await cloudService.saveContact(contact: contact);
    if (newContact != null) {
      await localService.saveContact(contact: newContact);
      await _fetchContacts();
    }
  }

  @action
  Future<void> init() async {
    await localService.db;
    await _fetchContacts();
  }

  @action
  Future<void> dispose() async {
    await localService.closeDb();
    _contacts.clear();
    _contactsFuture.value?.clear();
  }
}
