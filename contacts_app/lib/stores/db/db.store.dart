import 'package:mobx/mobx.dart';

import '../../models/contact.dart';
import '../../services/db/idb_service.dart';

part 'db.store.g.dart';

class DbStore = DbStoreBase with _$DbStore;

abstract class DbStoreBase with Store {
  DbStoreBase({required this.dbService});

  final IDbService dbService;

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
    _contactsFuture = ObservableFuture(dbService.getAllContacts());
    final data = await _contactsFuture;
    _contacts
      ..clear()
      ..addAll(data);
  }

  @action
  Future<void> addContact(Contact contact) async {
    final c = await dbService.saveContact(contact: contact);
    _contacts.add(c);
  }

  @action
  Future<void> init() async {
    await dbService.db;
    await _fetchContacts();
  }
  
  @action
  Future<void> dispose() async {
    await dbService.closeDb();
    _contacts.clear();
    _contactsFuture.value?.clear();
  }
}
