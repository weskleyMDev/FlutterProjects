part of 'connectivity_bloc.dart';

enum ConnectivityStatus { connected, disconnected, unknown }

final class ConnectivityState extends Equatable {
  const ConnectivityState._({required this.status});

  factory ConnectivityState.initial() =>
      const ConnectivityState._(status: ConnectivityStatus.unknown);

  final ConnectivityStatus status;

  ConnectivityState copyWith({ConnectivityStatus? status}) =>
      ConnectivityState._(status: status ?? this.status);

  @override
  List<Object?> get props => [status];
}
