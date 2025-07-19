import 'package:mobx/mobx.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../services/stock/stock_service.dart';

part 'stock.store.g.dart';

class StockStore = StockStoreBase with _$StockStore;

abstract class StockStoreBase with Store {
  StockStoreBase({required this.stockService});

  final IStockService stockService;

  @computed
  Stream<List<Product>> get products => stockService.getProducts();

  @action
  Future<Product?> addToStock({required StockFormData product}) async =>
      await stockService.save(product: product);
}
