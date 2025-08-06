import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/product/product.dart';
import 'package:shop_v2/services/stock/istock_service.dart';

part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeStoreBase({required this.stockService}) {
    _productStream = ObservableStream(stockService.products);
  }

  final IStockService stockService;

  @observable
  ObservableStream<List<Product>> _productStream = ObservableStream(
    Stream.empty(),
  );

  @computed
  Stream<List<Product>> get productsList => _productStream;
}
