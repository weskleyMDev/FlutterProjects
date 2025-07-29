import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/databases/cloud/icloud_db_service.dart';
import 'package:contacts_app/stores/database/local/local_db.store.dart';
import 'package:contacts_app/utils/binary_search.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'cloud_db.store.g.dart';

class CloudDbStore = CloudDbStoreBase with _$CloudDbStore;

abstract class CloudDbStoreBase with Store {
  CloudDbStoreBase({required this.cloudDbService});
  final ICloudDbService cloudDbService;

  @action
  Future<void> _addContact(Contact contact) async {
    await cloudDbService.saveContact(contact: contact);
  }

  @action
  Future<void> _updateContact(Contact contact) async {
    await cloudDbService.updateContact(contact: contact);
  }

  @action
  Future<void> saveContact(Map<String, dynamic> data) async {
    final localStore = GetIt.instance<LocalDbStore>();
    final Contact newContact = Contact.fromMap(data);
    final sortedContacts = List<Contact>.from(localStore.contactsList);
    sortedContacts.sort((a, b) => a.id.compareTo(b.id));
    final index = myBinarySearch(
      sortedContacts,
      newContact,
          (a, b) => a.id.compareTo(b.id),
    );
    if (index >= 0) {
      await _updateContact(newContact);
    } else {
      await _addContact(newContact);
    }
  }
}
