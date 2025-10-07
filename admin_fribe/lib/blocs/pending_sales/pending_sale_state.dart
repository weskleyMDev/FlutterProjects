part of 'pending_sale_bloc.dart';

enum PendingSaleStatus { initial, loading, success, failure }

final class PendingSaleState extends Equatable {
  final List<PendingSaleModel> pendingSales;
  final PendingSaleStatus status;
  final Set<String> expandedTiles;
  final String? errorMessage;

  const PendingSaleState._({
    this.pendingSales = const [],
    this.status = PendingSaleStatus.initial,
    this.expandedTiles = const {},
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

  PendingSaleState copyWith({
    List<PendingSaleModel> Function()? pendingSales,
    PendingSaleStatus Function()? status,
    Set<String> Function()? expandedTiles,
    String? Function()? errorMessage,
  }) => PendingSaleState._(
    pendingSales: pendingSales?.call() ?? this.pendingSales,
    status: status?.call() ?? this.status,
    expandedTiles: expandedTiles?.call() ?? this.expandedTiles,
    errorMessage: errorMessage?.call() ?? this.errorMessage,
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    pendingSales,
    status,
    expandedTiles,
    errorMessage,
  ];
}
