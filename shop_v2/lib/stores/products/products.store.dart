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

  @observable
  String? _categoryId;

  @computed
  String? get categoryId => _categoryId;

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
    switch (options) {
      case CategoriesList.tshirts:
        _categoryId = 'tshirts';
        _categoryLabel = AppLocalizations.of(context)!.tshirt(2);
        break;
      case CategoriesList.jackets:
        _categoryId = 'jackets';
        _categoryLabel = AppLocalizations.of(context)!.jacket(2);
        break;
      case CategoriesList.shorts:
        _categoryId = 'shorts';
        _categoryLabel = AppLocalizations.of(context)!.shorts(2);
        break;
      case CategoriesList.pants:
        _categoryId = 'pants';
        _categoryLabel = AppLocalizations.of(context)!.pants(2);
        break;
    }
    _productsStream = ObservableStream(
      _productsRepository.getProductsByCategory(category: _categoryId!),
    );
    _productsStream.listen((data) {
      _productsList.clear();
      _productsList.addAll(data);
    });
  }

  @action
  Future<ProductModel?> getProductsById(String category, String id) async {
    final product = await _productsRepository.getProductById(
      category: category,
      id: id,
    );
    return product;
  }

  @action
  void dispose() {
    _selectedSize = null;
  }
}
