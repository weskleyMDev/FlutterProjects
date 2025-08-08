import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/repositories/products/iproducts_repository.dart';

part 'products.store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

enum CategoriesList { tshirts, jackets, shorts, pants }

abstract class ProductsStoreBase with Store {
  ProductsStoreBase({required this.productsRepository});
  final IProductsRepository productsRepository;

  @observable
  String? categoryLabel;

  @observable
  int? _selectedIndex;

  @observable
  ObservableStream<List<ProductModel>> _productsStream = ObservableStream(
    Stream.empty(),
  );

  @computed
  Stream<List<ProductModel>> get productsList => _productsStream;

  @computed
  int? get selectedIndex => _selectedIndex;

  set selectedIndex(int? value) => _selectedIndex = value;

  @action
  Future<void> toggleCategory(
    BuildContext context,
    CategoriesList options,
  ) async {
    switch (options) {
      case CategoriesList.tshirts:
        categoryLabel = AppLocalizations.of(context)!.tshirt(2);
        _productsStream = ObservableStream(
          productsRepository.getProductsByCategory(category: 'tshirts'),
        );
        break;
      case CategoriesList.jackets:
        categoryLabel = AppLocalizations.of(context)!.jacket(2);
        _productsStream = ObservableStream(
          productsRepository.getProductsByCategory(category: 'jackets'),
        );
        break;
      case CategoriesList.shorts:
        categoryLabel = AppLocalizations.of(context)!.shorts(2);
        _productsStream = ObservableStream(
          productsRepository.getProductsByCategory(category: 'shorts'),
        );
        break;
      case CategoriesList.pants:
        categoryLabel = AppLocalizations.of(context)!.pants(2);
        _productsStream = ObservableStream(
          productsRepository.getProductsByCategory(category: 'pants'),
        );
        break;
    }
  }
}
