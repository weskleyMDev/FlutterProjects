import 'package:mobx/mobx.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../services/stock/istock_service.dart';

part 'stock.store.g.dart';

class StockStore = StockStoreBase with _$StockStore;

abstract class StockStoreBase with Store {
  StockStoreBase({required this.stockService}) {
    // _searchReaction = reaction<String>(
    //   (_) => searchQuery,
    //   (_) => _invalidateComputed(),
    //   delay: 300,
    // );
    //preloadProducts();
  }

  final IStockService stockService;

  //late final ReactionDisposer _searchReaction;

  @observable
  String searchQuery = '';

  @observable
  String currentCategory = '';

  //@observable
  //ObservableFuture<List<Product>>? productsFuture;

  @observable
  ObservableStream<List<Product>> _products = ObservableStream(
    Stream<List<Product>>.empty(),
  );

  //@computed
  //List<Product> get allProducts => productsFuture?.value ?? [];

  @computed
  Stream<List<Product>> get productsList => _products;

  @computed
  Future<void> get filterList =>
      fetchData(category: currentCategory, query: searchQuery);

  @action
  Future<void> fetchData({String? category, String? query}) async {
    final q = query?.toLowerCase() ?? '';
    final stream = stockService.getProducts().map((data) {
      return data.where((p) {
        final matchName = p.name.toLowerCase().contains(q);
        final matchCategory = category == null || category.isEmpty
            ? true
            : p.category.toUpperCase() == category.toUpperCase();
        return matchName && matchCategory;
      }).toList();
    });
    _products = ObservableStream(stream);
  }

  // @computed
  // List<Product> get filteredProducts =>
  //     getFilteredProducts(category: currentCategory, query: searchQuery);

  // List<Product> getFilteredProducts({String? category, String? query}) {
  //   final q = query?.toLowerCase() ?? '';
  //   return allProducts.where((p) {
  //     final matchName = p.name.toLowerCase().contains(q);
  //     final matchCategory = category == null || category.isEmpty
  //         ? true
  //         : p.category.toUpperCase() == category.toUpperCase();
  //     return matchName && matchCategory;
  //   }).toList();
  // }

  // @action
  // Future<void> preloadProducts() async {
  //   final future = stockService.getProducts().first;
  //   productsFuture = ObservableFuture(future);
  // }

  @action
  Future<Product?> addToStock({required StockFormData product}) async {
    final newProduct = await stockService.saveProduct(product: product);
    //await preloadProducts();
    return newProduct;
  }

  @action
  Future<void> removeProductById({required Product product}) async {
    await stockService.deleteProductById(product: product);
    //allProducts.removeWhere((p) => p.id == product.id);
    //_invalidateComputed();
  }

  @action
  Future<void> updateProduct({
    required Product product,
    required StockFormData data,
  }) async {
    await stockService.updateProductById(product: product, data: data);
    //final updatedProduct = Product.fromMap(data.toMap(), product.id);

    //final index = allProducts.indexWhere((p) => p.id == product.id);
    //if (index != -1) allProducts[index] = updatedProduct;

    //_invalidateComputed();
  }

  @action
  Future<void> removeAllByCategory({required String category}) async {
    await stockService.clearByCategory(category: category);
    //allProducts.removeWhere((p) => p.category == category);
    //_invalidateComputed();
  }

  @action
  void setCategory(String category) {
    currentCategory = category;
  }

  @action
  void reset() {
    searchQuery = '';
    currentCategory = '';
  }

  // @action
  // void _invalidateComputed() {
  //   searchQuery = searchQuery;
  //   currentCategory = currentCategory;
  // }

  void dispose() {
    //_searchReaction();
  }
}
