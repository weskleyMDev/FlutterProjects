import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/backups/ibackup_service.dart';
import 'package:contacts_app/services/databases/cloud/icloud_db_service.dart';
import 'package:contacts_app/services/databases/local/ilocal_db_service.dart';
import 'package:mobx/mobx.dart';

part 'local_db.store.g.dart';

class LocalDbStore = LocalDbStoreBase with _$LocalDbStore;

abstract class LocalDbStoreBase with Store {
  LocalDbStoreBase({
    required this.localService,
    required this.backupService,
    required this.cloudService,
  });

  final ILocalDbService localService;
  final IBackupService backupService;
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
    // para ler do arquivo de backup
    // final map = await backupService.readBackup();
    // List<Contact> list = [];
    // if (map != null && map['backup'] != null) {
    //   list = (map['backup'] as List)
    //     .map((e) => Contact.fromMap(e as Map<String, dynamic>))
    //     .toList();
    // }
    _contactsFuture = ObservableFuture(localService.getAllContacts());
    final data = await _contactsFuture;
    _contacts
      ..clear()
      ..addAll(data);
    return _contacts;
  }

  @action
  Future<void> addContact(Contact contact) async {
    final backup = await backupService.readBackup();
    if (backup!.containsKey('backup')) {
      var existIndex = backup['backup']!.indexWhere((i) => i['id'] == contact.id);
      if (existIndex != -1) {
        backup['backup']![existIndex] = contact.toMap();
      } else {
        backup['backup']!.add(contact.toMap());
      }
    } else {
      backup.putIfAbsent('backup', () => [contact.toMap()]);
    }
    await backupService.saveBackup(backup);
    await localService.saveContact(contact: contact);
    await cloudService.saveContact(contact: contact);
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
