import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/repositories/products/iproducts_repository.dart';

part 'products.store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

enum CategoriesList { tshirts, jackets, shorts, pants }

abstract class ProductsStoreBase with Store {
  ProductsStoreBase({required IProductsRepository productsRepository})
    : _productsRepository = productsRepository;
  final IProductsRepository _productsRepository;

  @observable
  String? _categoryLabel;

  @observable
  int? _selectedSize;

  @observable
  ObservableStream<List<ProductModel>> _productsStream = ObservableStream(
    Stream.empty(),
  );

  @computed
  Stream<List<ProductModel>> get productsList => _productsStream;

  @computed
  String? get categoryLabel => _categoryLabel;

  @computed
  int? get selectedSize => _selectedSize;

  set selectedSize(int? value) => _selectedSize = value;

  @action
  Future<void> toggleCategory(
    BuildContext context,
    CategoriesList options,
  ) async {
    switch (options) {
      case CategoriesList.tshirts:
        _categoryLabel = AppLocalizations.of(context)!.tshirt(2);
        _productsStream = ObservableStream(
          _productsRepository.getProductsByCategory(category: 'tshirts'),
        );
        break;
      case CategoriesList.jackets:
        _categoryLabel = AppLocalizations.of(context)!.jacket(2);
        _productsStream = ObservableStream(
          _productsRepository.getProductsByCategory(category: 'jackets'),
        );
        break;
      case CategoriesList.shorts:
        _categoryLabel = AppLocalizations.of(context)!.shorts(2);
        _productsStream = ObservableStream(
          _productsRepository.getProductsByCategory(category: 'shorts'),
        );
        break;
      case CategoriesList.pants:
        _categoryLabel = AppLocalizations.of(context)!.pants(2);
        _productsStream = ObservableStream(
          _productsRepository.getProductsByCategory(category: 'pants'),
        );
        break;
    }
  }

  @action
  void dispose() {
    _selectedSize = null;
  }
}
