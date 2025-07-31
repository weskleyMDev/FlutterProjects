import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/services/databases/cloud/icloud_db_service.dart';

class CloudDbService implements ICloudDbService {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteContact({required String id}) async {
    final snapshot = await _firestore
        .collection('contacts')
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final docRef = snapshot.docs.first.id;
      await _firestore.collection('contacts').doc(docRef).delete();
    }
  }

  @override
  Stream<List<Contact>> getAllContacts() {
    final snapshots = _firestore
        .collection('contacts')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('name')
        .snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Stream<Map<String, dynamic>> getContact({required String id}) {
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
  Future<void> updateContact({required Contact contact}) async {
    final snapshot = await _firestore
        .collection('contacts')
        .where('id', isEqualTo: contact.id)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final docRef = snapshot.docs.first.id;

      await _firestore
          .collection('contacts')
          .doc(docRef)
          .update(contact.toMap());
    }
  }

  Map<String, dynamic> _toFirestore(Contact contact, SetOptions? options) =>
      contact.toMap();

  Contact _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
    SnapshotOptions? otions,
  ) => Contact.fromMap(snapshot.data()!);

  Future<void> syncData(List<Contact> contacts) async {
    for (var contact in contacts) {
      final contactMap = contact.toMap();

      final docRef = _firestore.collection('contacts').doc(contact.id);
      await docRef.set(contactMap, SetOptions(merge: true));
    }
  }
}
