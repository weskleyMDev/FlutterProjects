import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/backups/ibackup_service.dart';
import 'package:contacts_app/services/databases/local/ilocal_db_service.dart';
import 'package:mobx/mobx.dart';

part 'db.store.g.dart';

class DbStore = DbStoreBase with _$DbStore;

abstract class DbStoreBase with Store {
  DbStoreBase({required this.localService, required this.backupService});

  final ILocalDbService localService;
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
  Future<List<Contact>> _fetchContacts() async {
    // para ler do arquivo de backup
    final map = await backupService.readData();
    // List<Contact> list = [];
    // if (map != null && map['backup'] != null) {
    //   list = (map['backup'] as List)
    //     .map((e) => Contact.fromMap(e as Map<String, dynamic>))
    //     .toList();
    // }
    print(map);
    _contactsFuture = ObservableFuture(localService.getAllContacts());
    final data = await _contactsFuture;
    _contacts
      ..clear()
      ..addAll(ObservableList.of(data));
    return _contacts;
  }

  @action
  Future<void> addContact(Contact contact) async {
    final map = await backupService.readData();
    if (map!.containsKey('backup')) {
      var existIndex = map['backup']!.indexWhere((i) => i['id'] == contact.id);
      if (existIndex != -1) {
        map['backup']![existIndex] = contact.toMap();
      } else {
        map['backup']!.add(contact.toMap());
      }
    } else {
      map.putIfAbsent('backup', () => [contact.toMap()]);
    }
    await localService.saveContact(contact: contact);
    await backupService.saveData(map);
    await _fetchContacts();
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
