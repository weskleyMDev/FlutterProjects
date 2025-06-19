import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'data_service.dart';

class FirebaseDataService implements DataService {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ChatMessage>> messagesStream() {
    final snapshots = _firestore
        .collection('messages')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createAt', descending: true)
        .snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
    /* return Stream<List<ChatMessage>>.multi((controller) {
      snapshots.listen((event) {
        List<ChatMessage> messages = event.docs
            .map((doc) => doc.data())
            .toList();
        controller.add(messages);
      }); 
    }); */
  }

  @override
  Future<ChatMessage?> saveMessage(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: '',
      text: text,
      createAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImage: user.imageUrl,
    );

    //final messageMap = newMessage.toMap();

    final docRef = await _firestore
        .collection('messages')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(newMessage);

    final doc = await docRef.get();
    //final message = ChatMessage.fromMap(doc.data()!, doc.id);

    return doc.data();
    //return message;
  }

  Map<String, dynamic> _toFirestore(ChatMessage message, SetOptions? options) {
    return message.toMap();
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return ChatMessage.fromMap(snapshot.data()!, snapshot.id);
  }
}
