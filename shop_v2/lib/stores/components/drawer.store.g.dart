// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DrawerStore on DrawerStoreBase, Store {
  Computed<DrawerOptions>? _$selectedOptionComputed;

  @override
  DrawerOptions get selectedOption =>
      (_$selectedOptionComputed ??= Computed<DrawerOptions>(
        () => super.selectedOption,
        name: 'DrawerStoreBase.selectedOption',
      )).value;
  Computed<bool>? _$isHomeComputed;

  @override
  bool get isHome => (_$isHomeComputed ??= Computed<bool>(
    () => super.isHome,
    name: 'DrawerStoreBase.isHome',
  )).value;
  Computed<bool>? _$isProfileComputed;

  @override
  bool get isProfile => (_$isProfileComputed ??= Computed<bool>(
    () => super.isProfile,
    name: 'DrawerStoreBase.isProfile',
  )).value;
  Computed<bool>? _$isProductsComputed;

  @override
  bool get isProducts => (_$isProductsComputed ??= Computed<bool>(
    () => super.isProducts,
    name: 'DrawerStoreBase.isProducts',
  )).value;
  Computed<bool>? _$isOrdersComputed;

  @override
  bool get isOrders => (_$isOrdersComputed ??= Computed<bool>(
    () => super.isOrders,
    name: 'DrawerStoreBase.isOrders',
  )).value;

  late final _$_selectedOptionAtom = Atom(
    name: 'DrawerStoreBase._selectedOption',
    context: context,
  );

  @override
  DrawerOptions get _selectedOption {
    _$_selectedOptionAtom.reportRead();
    return super._selectedOption;
  }

  @override
  set _selectedOption(DrawerOptions value) {
    _$_selectedOptionAtom.reportWrite(value, super._selectedOption, () {
      super._selectedOption = value;
    });
  }

  late final _$DrawerStoreBaseActionController = ActionController(
    name: 'DrawerStoreBase',
    context: context,
  );

  @override
  void toggleOption(DrawerOptions option) {
    final _$actionInfo = _$DrawerStoreBaseActionController.startAction(
      name: 'DrawerStoreBase.toggleOption',
    );
    try {
      return super.toggleOption(option);
    } finally {
      _$DrawerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedOption: ${selectedOption},
isHome: ${isHome},
isProfile: ${isProfile},
isProducts: ${isProducts},
isOrders: ${isOrders}
    ''';
  }
}
