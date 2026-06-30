import 'package:admin_fribe/logs/enum/log_action.dart';
import 'package:admin_fribe/models/log_model.dart';
import 'package:admin_fribe/models/log_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'ilog_repository.dart';

final class LogRepository implements ILogRepository {
  final FirebaseFirestore _firestore;

  LogRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // ----------------------------
  // WRITE
  // ----------------------------
  @override
  Future<void> saveLog(LogModel log) async {
    await _firestore.collection('logs').add(log.toMap());
  }

  // ----------------------------
  // READ: BY PRODUCT
  // ----------------------------
  @override
  Future<List<LogViewModel>> getLogsByProductID({
    required String productId,
    LogAction? action,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('logs')
        .where('productId', isEqualTo: productId);

    if (action != null) {
      query = query.where('action', isEqualTo: action.name);
    }

    final snapshot = await query
        .orderBy('timestamp', descending: true)
        .limit(5)
        .get();

    final productName = await _getSingleProductName(productId);

    return snapshot.docs
        .map(
          (doc) => _toViewModel(
            doc.data(),
            productId: productId,
            productName: productName,
          ),
        )
        .toList();
  }

  // ----------------------------
  // READ: GLOBAL (LAST 20)
  // ----------------------------
  @override
  Future<List<LogViewModel>> getLast20Logs(LogAction? action) async {
    Query<Map<String, dynamic>> query = _firestore.collection('logs');

    if (action != null) {
      query = query.where('action', isEqualTo: action.name);
    }

    final snapshot = await query
        .orderBy('timestamp', descending: true)
        .limit(20)
        .get();

    final productIds = snapshot.docs
        .map((doc) => doc['productId'] as String)
        .toSet();

    final productNames = await _getProductNames(productIds);

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final productId = data['productId'] as String;

      return _toViewModel(
        data,
        productId: productId,
        productName: productNames[productId] ?? productId,
      );
    }).toList();
  }

  // ----------------------------
  // PRODUCT LOOKUP (BATCH)
  // ----------------------------
  final Map<String, String> _productNameCache = {};

  Future<Map<String, String>> _getProductNames(Set<String> ids) async {
    final missing = ids
        .where((id) => !_productNameCache.containsKey(id))
        .toSet();

    if (missing.isNotEmpty) {
      final chunks = missing.toList().chunked(10);

      for (final chunk in chunks) {
        final snapshot = await _firestore
            .collection('stock')
            .where(FieldPath.documentId, whereIn: chunk)
            .get();

        for (final doc in snapshot.docs) {
          _productNameCache[doc.id] = doc['name'] as String? ?? 'Unknown';
        }
      }
    }

    return {for (final id in ids) id: _productNameCache[id] ?? 'Unknown'};
  }

  Future<String> _getSingleProductName(String id) async {
    if (_productNameCache.containsKey(id)) {
      return _productNameCache[id]!;
    }

    final doc = await _firestore.collection('stock').doc(id).get();

    final name = doc.data()?['name'] as String? ?? 'Unknown';

    _productNameCache[id] = name;

    return name;
  }

  // ----------------------------
  // MAPPER
  // ----------------------------
  LogViewModel _toViewModel(
    Map<String, dynamic> data, {
    required String productId,
    required String productName,
  }) {
    final payload = Map<String, dynamic>.from(data['payload'] as Map? ?? {});

    return LogViewModel(
      productId: productId,
      productName: productName,
      action: _parseAction(data['action']),
      oldAmount: _safeString(payload['oldAmount']),
      newAmount: _safeString(payload['newAmount']),
      addedAmount: _safeString(payload['addedAmount']),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // ----------------------------
  // SAFE HELPERS
  // ----------------------------
  LogAction _parseAction(dynamic value) {
    return LogAction.values.firstWhere(
      (e) => e.name == value,
      orElse: () => LogAction.updateAmount,
    );
  }

  String _safeString(dynamic value) {
    if (value == null) return '0';
    if (value is String) return value;
    return value.toString();
  }
}

extension ListChunkExtension<T> on List<T> {
  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];

    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }

    return chunks;
  }
}
