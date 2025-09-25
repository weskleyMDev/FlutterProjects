part of 'home_tab_cubit.dart';

enum HomeTabs { products, cart }

final class HomeTabState extends Equatable {
  final HomeTabs currentTab;

  const HomeTabState._({this.currentTab = HomeTabs.products});

  const HomeTabState.initial() : this._();

  HomeTabState copyWith({HomeTabs Function()? currentTab}) =>
      HomeTabState._(currentTab: currentTab?.call() ?? this.currentTab);

  @override
  List<Object?> get props => [currentTab];
}
