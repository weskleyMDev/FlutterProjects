import 'package:equatable/equatable.dart';
import 'package:seller_fribe/models/pending_receipt_model.dart';

enum PendingSalesStatus { initial, loading, success, failure }

final class PendingSalesState extends Equatable {
  final List<PendingReceiptModel> pendingSales;
  final PendingSalesStatus status;
  final String? errorMessage;
  const PendingSalesState._({
    this.pendingSales = const [],
    this.status = PendingSalesStatus.initial,
    this.errorMessage,
  });

  factory PendingSalesState.initial() => const PendingSalesState._();

  factory PendingSalesState.loading() =>
      const PendingSalesState._(status: PendingSalesStatus.loading);

  factory PendingSalesState.success(List<PendingReceiptModel> pendingSales) =>
      PendingSalesState._(
        status: PendingSalesStatus.success,
        pendingSales: pendingSales,
      );

  factory PendingSalesState.failure(String? errorMessage) => PendingSalesState._(
    status: PendingSalesStatus.failure,
    errorMessage: errorMessage,
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [pendingSales, status, errorMessage];
}
