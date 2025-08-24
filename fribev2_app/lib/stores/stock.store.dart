import 'dart:async';

import 'package:mobx/mobx.dart';

import '../models/product.dart';
import '../services/stock/istock_service.dart';

part 'stock.store.g.dart';

class StockStore = StockStoreBase with _$StockStore;

abstract class StockStoreBase with Store {
  StockStoreBase(this._stockService) {
    _categoryDisposer = reaction<String?>(
      (_) => currentCategory,
      (_) => fetchData(category: currentCategory),
    );
  }

  final IStockService _stockService;
  late final ReactionDisposer _categoryDisposer;
  StreamSubscription? _subscription;

  @observable
  String searchQuery = '';

  @observable
  String? currentCategory;

  @observable
  ObservableStream<List<Product>> _productStream =
      ObservableStream<List<Product>>(Stream.empty());

  @observable
  ObservableList<Product> _productsByCategory = ObservableList<Product>();

  @computed
  StreamStatus get productStreamStatus => _productStream.status;

  @computed
  List<Product> get filteredProducts {
    final query = searchQuery.toLowerCase();
    return List.unmodifiable(
      _productsByCategory
          .where((p) => p.name.toLowerCase().startsWith(query))
          .toList(),
    );
  }

  @action
  Future<void> fetchData({String? category}) async {
    await _subscription?.cancel();
    _productStream = _stockService.getProducts().map((data) {
      return data.where((p) {
        final matchCategory = category == null || category.isEmpty
            ? true
            : p.category.toUpperCase() == category.toUpperCase();
        return matchCategory;
      }).toList();
    }).asObservable();
    _subscription = _productStream.listen((data) {
      _productsByCategory
        ..clear()
        ..addAll(data);
    });
  }

  @action
  Future<Product?> getProductById({required String id}) async {
    final product = await _stockService.getProductById(id: id);
    return product;
  }

  @action
  Future<Product?> addToStock({required Product product}) async {
    final newProduct = await _stockService.saveProduct(product: product);
    return newProduct;
  }

  @action
  Future<void> removeProductById({required Product product}) async {
    await _stockService.deleteProductById(product: product);
  }

  @action
  Future<void> updateProduct({required Product product}) async {
    await _stockService.updateProductById(product: product);
  }

  @action
  Future<void> updateQuantityById({
    required String id,
    required String quantity,
  }) async {
    await _stockService.updateQuantityById(id: id, quantity: quantity);
  }

  @action
  Future<void> removeAllByCategory({required String category}) async {
    await _stockService.clearByCategory(category: category);
  }

  @action
  Future<void> disposeStock() async {
    await _subscription?.cancel();
    searchQuery = '';
    currentCategory = '';
    _subscription = null;
    _productsByCategory.clear();
    _categoryDisposer();
    print('DISPOSE STOCK STORE!!');
  }
}
