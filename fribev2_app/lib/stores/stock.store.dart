import 'package:mobx/mobx.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../services/stock/stock_service.dart';

part 'stock.store.g.dart';

class StockStore = StockStoreBase with _$StockStore;

abstract class StockStoreBase with Store {
  StockStoreBase({required this.stockService}) {
    _initProductListener();
  }

  final IStockService stockService;

  @observable
  late Stream<List<Product>> _productStream = stockService.getProducts();

  @observable
  ObservableList<Product> productList = ObservableList<Product>();

  @action
  void _initProductListener() {
    _productStream.listen((data) {
      productList
        ..clear()
        ..addAll(data);
    });
  }

  @computed
  Stream<List<Product>> get products => _productStream;

  @action
  Future<Product?> addToStock({required StockFormData product}) async =>
      await stockService.save(product: product);
}
