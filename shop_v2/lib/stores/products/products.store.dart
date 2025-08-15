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

  @observable
  ObservableList<ProductModel> _productsList = ObservableList<ProductModel>();

  @computed
  ObservableList<ProductModel> get productsList => _productsList;

  @computed
  String? get categoryLabel => _categoryLabel;

  @computed
  int? get selectedSize => _selectedSize;

  @computed
  StreamStatus get status => _productsStream.status;

  set selectedSize(int? value) => _selectedSize = value;

  @action
  Future<void> toggleCategory(
    BuildContext context,
    CategoriesList options,
  ) async {
    final String category;
    switch (options) {
      case CategoriesList.tshirts:
        category = 'tshirts';
        _categoryLabel = AppLocalizations.of(context)!.tshirt(2);
        break;
      case CategoriesList.jackets:
        category = 'jackets';
        _categoryLabel = AppLocalizations.of(context)!.jacket(2);
        break;
      case CategoriesList.shorts:
        category = 'shorts';
        _categoryLabel = AppLocalizations.of(context)!.shorts(2);
        break;
      case CategoriesList.pants:
        category = 'pants';
        _categoryLabel = AppLocalizations.of(context)!.pants(2);
        break;
    }
    _productsStream = ObservableStream(
      _productsRepository.getProductsByCategory(category: category),
    );
    _productsStream.listen((data) {
      _productsList.clear();
      _productsList.addAll(data);
    });
  }

  @action
  void dispose() {
    _selectedSize = null;
  }
}
