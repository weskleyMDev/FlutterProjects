import 'package:contacts_app/models/contact.dart';

abstract class ICloudDbService {
  Stream<Contact> getContact({required String id});
  Stream<List<Contact>> getAllContacts();
  Future<Contact?> saveContact({required Contact contact});
  Future<void> deleteContact({required String id});
  Future<void> updateContact({required Contact contact});
}
