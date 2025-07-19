import 'package:mobx/mobx.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../services/stock/stock_service.dart';

part 'stock.store.g.dart';

class StockStore = StockStoreBase with _$StockStore;

abstract class StockStoreBase with Store {
  StockStoreBase({required this.stockService}) {
    _searchReaction = reaction<String>(
      (_) => searchQuery,
      (_) => loadProductByCategory(),
      delay: 300,
    );
    preloadProducts();
  }

  IStockService stockService;

  late ReactionDisposer _searchReaction;

  @observable
  String searchQuery = '';

  @observable
  String currentCategory = '';

  @observable
  ObservableList<Product> _productList = ObservableList<Product>();

  @observable
  List<Product> allProducts = [];

  @computed
  List<Product> get productList => List.unmodifiable(_productList);

  @action
  Future<void> preloadProducts() async {
    allProducts = await stockService.getProducts().first;
    loadProductByCategory();
  }

  @action
  Future<void> loadProductByCategory() async {
    final query = searchQuery.toLowerCase();
    final filtered = allProducts.where((p) {
      final matchesName = p.name.toLowerCase().contains(query);
      final matchesCategory =
          p.category.toUpperCase() == currentCategory.toUpperCase();
      return matchesName && matchesCategory;
    }).toList();

    _productList
      ..clear()
      ..addAll(filtered);
  }

  @action
  Future<Product?> addToStock({required StockFormData product}) async =>
      await stockService.save(product: product);

  @action
  void setCategory(String category) {
    currentCategory = category;
    loadProductByCategory();
  }

  @action
  void reset() {
    searchQuery = '';
    currentCategory = '';
    _productList.clear();
  }

  void dispose() {
    _searchReaction();
  }
}
