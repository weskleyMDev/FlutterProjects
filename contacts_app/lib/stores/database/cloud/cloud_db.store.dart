import 'dart:async';

import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/databases/cloud/icloud_db_service.dart';
import 'package:contacts_app/utils/binary_search.dart';
import 'package:mobx/mobx.dart';

part 'cloud_db.store.g.dart';

class CloudDbStore = CloudDbStoreBase with _$CloudDbStore;

abstract class CloudDbStoreBase with Store {
  CloudDbStoreBase({required this.cloudDbService});

  final ICloudDbService cloudDbService;

  @observable
  ObservableStream<List<Contact>> _contactsStream = ObservableStream(
    Stream<List<Contact>>.empty(),
  );

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
    final stream = cloudDbService.getAllContacts();
    _contactsFuture = ObservableFuture(stream.first);
    _contactsStream = ObservableStream(stream);
    _contactsStream.listen((data) {
      _contacts
        ..clear()
        ..addAll(data);
    });
  }

  @action
  Future<void> _addContact(Contact contact) async {
    await cloudDbService.saveContact(contact: contact);
  }

  @action
  Future<void> _updateContact(Contact contact) async {
    await cloudDbService.updateContact(contact: contact);
  }

  @action
  Future<void> deleteContact({required String id}) async {
    await cloudDbService.deleteContact(id: id);
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
      _contacts[index] = newContact;
      await _updateContact(newContact);
    } else {
      _contacts.add(newContact);
      await _addContact(newContact);
    }
  }

  @action
  Future<void> init() async {
    await _fetchContacts();
  }
}
