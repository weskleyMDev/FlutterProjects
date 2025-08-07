import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/products/products_off.dart';
import 'package:shop_v2/services/showcase/ishowcase_service.dart';

part 'showcase.store.g.dart';

class ShowcaseStore = ShowcaseStoreBase with _$ShowcaseStore;

abstract class ShowcaseStoreBase with Store {
  ShowcaseStoreBase({required this.showcaseService}) {
    _productStream = ObservableStream(showcaseService.products);
  }

  final IShowcaseService showcaseService;

  @observable
  ObservableStream<List<ProductOff>> _productStream = ObservableStream(
    Stream.empty(),
  );

  @computed
  Stream<List<ProductOff>> get productsList => _productStream;
}
