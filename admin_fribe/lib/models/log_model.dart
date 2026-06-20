import 'package:admin_fribe/logs/enum/log_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class LogModel extends Equatable {
  final LogAction action;
  final String productId;
  final DateTime timestamp;
  final Map<String, dynamic> payload;

  const LogModel({
    required this.action,
    required this.productId,
    required this.timestamp,
    required this.payload,
  });

  Map<String, dynamic> toMap() {
    return {
      'action': action.name,
      'productId': productId,
      'timestamp': Timestamp.fromDate(timestamp),
      'payload': payload,
    };
  }

  factory LogModel.fromMap(Map<String, dynamic> map) {
    final actionName = map['action'] as String;
    final action = LogAction.values.firstWhere(
      (a) => a.name == actionName,
      orElse: () =>
          LogAction.updateAmount, // Default value if no match is found
    );
    return LogModel(
      action: action,
      productId: map['productId'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      payload: Map<String, dynamic>.from(map['payload'] as Map),
    );
  }

  @override
  List<Object?> get props => [action, productId, timestamp, payload];
}

extension LogPayloadX on LogModel {
  String get oldAmount => payload['oldAmount'] ?? '';
  String get addedAmount => payload['addedAmount'] ?? '';
  String get newAmount => payload['newAmount'] ?? '';
}
