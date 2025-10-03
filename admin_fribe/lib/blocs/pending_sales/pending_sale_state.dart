part of 'pending_sale_bloc.dart';

enum PendingSaleStatus { initial, loading, success, failure }

final class PendingSaleState extends Equatable {
  final List<PendingSaleModel> pendingSales;
  final PendingSaleStatus status;
  final String? errorMessage;

  const PendingSaleState._({
    this.pendingSales = const [],
    this.status = PendingSaleStatus.initial,
    this.errorMessage,
  });

  factory PendingSaleState.initial() => const PendingSaleState._();

  factory PendingSaleState.loading() =>
      const PendingSaleState._(status: PendingSaleStatus.loading);

  factory PendingSaleState.success(List<PendingSaleModel> pendingSales) =>
      PendingSaleState._(
        status: PendingSaleStatus.success,
        pendingSales: pendingSales,
      );

  factory PendingSaleState.failure(String? errorMessage) => PendingSaleState._(
    status: PendingSaleStatus.failure,
    errorMessage: errorMessage,
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [pendingSales, status, errorMessage];
}
