import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/databases/cloud/icloud_db_service.dart';

class CloudDbService implements ICloudDbService {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteContact({required String id}) {
    // TODO: implement deleteContact
    throw UnimplementedError();
  }

  @override
  Stream<List<Contact>> getAllContacts() {
    // TODO: implement getAllContacts
    throw UnimplementedError();
  }

  @override
  Stream<Contact> getContact({required String id}) {
    // TODO: implement getContact
    throw UnimplementedError();
  }

  @override
  Future<Contact?> saveContact({required Contact contact}) async {
    final docRef = await _firestore
        .collection('contacts')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(contact);
    final doc = await docRef.get();
    return doc.data();
  }

  @override
  Future<void> updateContact({required Contact contact}) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }

  Map<String, dynamic> _toFirestore(Contact contact, SetOptions? options) =>
      contact.toMap();

  Contact _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
    SnapshotOptions? otions,
  ) => Contact.fromMap(snapshot.data()!);
}
