import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/order/order_model.dart';
import 'package:shop_v2/models/order/product_order.dart';
import 'package:shop_v2/repositories/order/iorder_repository.dart';
import 'package:shop_v2/services/order/iorder_service.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';
import 'package:shop_v2/stores/products/products.store.dart';

part 'order.store.g.dart';

class OrderStore = OrderStoreBase with _$OrderStore;

abstract class OrderStoreBase with Store {
  OrderStoreBase(this._orderRepository, this._orderService);
  final IOrderRepository _orderRepository;
  final IOrderService _orderService;

  @observable
  ObservableStream<List<OrderModel>> _orderStream = ObservableStream(
    Stream.empty(),
  );

  @observable
  ObservableMap<String, dynamic> _data = ObservableMap();

  @computed
  ObservableStream<List<OrderModel>> get orderStream => _orderStream;

  @computed
  StreamStatus get orderStatus => _orderStream.status;

  @computed
  ObservableMap<String, dynamic> get data => _data;

  set data(Map<String, dynamic> data) => _data = ObservableMap.of(data);

  @action
  void fetchOrders() {
    final authStore = GetIt.instance<AuthStore>();
    authStore.userChanges.listen((user) {
      if (user != null) {
        _orderStream = ObservableStream(_orderRepository.getOrders(user.id!));
      } else {
        _orderStream = ObservableStream(Stream.empty());
      }
    });
    final currentUser = authStore.currentUser;
    if (currentUser != null) {
      _orderStream = ObservableStream(
        _orderRepository.getOrders(currentUser.id!),
      );
    }
  }

  @action
  Future<List<ProductOrder>> fetchProductsForOrder(List<CartItem> items) async {
    final productStore = GetIt.instance<ProductsStore>();

    final productOrders = await Future.wait(
      items.map((item) async {
        final product = await productStore.getProductsById(
          item.category,
          item.productId,
        );
        if (product != null) {
          return ProductOrder(
            product: product,
            quantity: item.quantity,
            size: item.size,
          );
        } else {
          return null;
        }
      }),
    );

    return productOrders.whereType<ProductOrder>().toList();
  }

  @action
  Future<void> saveOrder() async {
    _data['userId'] = GetIt.instance<AuthStore>().currentUser?.id;
    _data['products'] = GetIt.instance<CartStore>().cartItems;
    _data['total'] = GetIt.instance<CartStore>().total;
    await _orderService.saveOrder(data);
  }
}
