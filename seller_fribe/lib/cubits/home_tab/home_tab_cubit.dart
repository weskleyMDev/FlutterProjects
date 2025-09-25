import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_tab_state.dart';

final class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(const HomeTabState.initial());

  void switchTab(HomeTabs tab) => emit(state.copyWith(currentTab: () => tab));
}
