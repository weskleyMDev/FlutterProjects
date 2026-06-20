import 'package:admin_fribe/logs/enum/log_action.dart';
import 'package:admin_fribe/models/log_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'ilog_repository.dart';

final class LogRepository implements ILogRepository {
  final FirebaseFirestore _firestore;

  LogRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> saveLog(LogModel log) async {
    await _firestore
        .collection('logs')
        .withConverter<LogModel>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(log);
  }

  @override
  Future<List<LogModel>> getLogs({
    required String productId,
    LogAction? action,
  }) async {
    Query<LogModel> query = _firestore
        .collection('logs')
        .withConverter<LogModel>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .where('productId', isEqualTo: productId);

    if (action != null) {
      query = query.where('action', isEqualTo: action.name);
    }

    query = query.orderBy('timestamp', descending: true).limit(5);

    final snapshot = await query.get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Map<String, dynamic> _toFirestore(LogModel log, SetOptions? options) =>
      log.toMap();

  LogModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Invalid log data!');
    }
    return LogModel.fromMap(data);
  }
}
