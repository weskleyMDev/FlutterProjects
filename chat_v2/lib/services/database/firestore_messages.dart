import 'package:chat_v2/models/message.dart';
import 'package:chat_v2/services/database/idatabase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessages implements IDatabaseService {
  static final _firestore = FirebaseFirestore.instance;

  Stream<List<Message>> _fetchMessages() {
    return _firestore
        .collection('messages')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Map<String, dynamic> _toFirestore(Message message, SetOptions? options) =>
      message.toMap();

  Message _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>?> snapshot,
    SnapshotOptions? options,
  ) {
    if (snapshot.data() != null) {
      return Message.fromMap(snapshot.data()!);
    } else {
      throw Exception('Document data is null');
    }
  }

  @override
  Stream<List<Message>> get messages => _fetchMessages();

  @override
  Future<void> sendMessage(Message message) async {
    await _firestore
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());
  }
}
