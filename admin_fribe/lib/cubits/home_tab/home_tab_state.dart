part of 'home_tab_cubit.dart';

enum HomeTabs { report, sales, vouchers, products }

final class HomeTabState extends Equatable {
  final HomeTabs tab;

  const HomeTabState._({required this.tab});

  factory HomeTabState.initial() => const HomeTabState._(tab: HomeTabs.report);

  HomeTabState copyWith({HomeTabs Function()? tab}) {
    return HomeTabState._(tab: tab?.call() ?? this.tab);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [tab];
}
