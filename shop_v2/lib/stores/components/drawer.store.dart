import 'package:mobx/mobx.dart';

part 'drawer.store.g.dart';

class DrawerStore = DrawerStoreBase with _$DrawerStore;

enum DrawerOptions { home, profile, products, orders }

abstract class DrawerStoreBase with Store {
  @observable
  DrawerOptions _selectedOption = DrawerOptions.home;

  @computed
  DrawerOptions get selectedOption => _selectedOption;

  @computed
  bool get isHome => _selectedOption == DrawerOptions.home;

  @computed
  bool get isProfile => _selectedOption == DrawerOptions.profile;

  @computed
  bool get isProducts => _selectedOption == DrawerOptions.products;

  @computed
  bool get isOrders => _selectedOption == DrawerOptions.orders;

  @action
  void toggleOption(DrawerOptions option) {
    _selectedOption = option;
  }
}
