import 'package:mobx/mobx.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../services/stock/istock_service.dart';

part 'stock.store.g.dart';

class StockStore = StockStoreBase with _$StockStore;

abstract class StockStoreBase with Store {
  StockStoreBase({required this.stockService});
  final IStockService stockService;

  @observable
  String searchQuery = '';

  @observable
  String currentCategory = '';

  @observable
  ObservableStream<List<Product>> _products = ObservableStream(
    Stream<List<Product>>.empty(),
  );

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
        final matchName = p.name.toLowerCase().startsWith(q);
        final matchCategory = category == null || category.isEmpty
            ? true
            : p.category.toUpperCase() == category.toUpperCase();
        return matchName && matchCategory;
      }).toList();
    });
    _products = ObservableStream(stream);
  }

  @action
  Future<Product?> addToStock({required StockFormData product}) async {
    final newProduct = await stockService.saveProduct(product: product);
    return newProduct;
  }

  @action
  Future<void> removeProductById({required Product product}) async {
    await stockService.deleteProductById(product: product);
  }

  @action
  Future<void> updateProduct({
    required Product product,
    required StockFormData data,
  }) async {
    await stockService.updateProductById(product: product, data: data);
  }

  @action
  Future<void> removeAllByCategory({required String category}) async {
    await stockService.clearByCategory(category: category);
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

  void dispose() {
    reset();
  }
}
