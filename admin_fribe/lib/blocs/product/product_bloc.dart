import 'package:admin_fribe/models/cart_item_model.dart';
import 'package:admin_fribe/models/cart_product.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'product_event.dart';
part 'product_state.dart';

final class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductState.initial()) {
    on<LoadProductsStream>(
      _onLoadProducts,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<GetProductById>(_onLoadProductById);
  }

  Future<void> _onLoadProducts(
    LoadProductsStream event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => ProductStatus.loading,
        errorMessage: () => null,
      ),
    );
    final products = _productRepository.getAllProducts();
    await emit.forEach<List<ProductModel?>>(
      products,
      onData: (data) => state.copyWith(
        products: () => data,
        status: () => ProductStatus.success,
        errorMessage: () => null,
      ),
      onError: (error, _) => state.copyWith(
        status: () => ProductStatus.failure,
        errorMessage: () =>
            error is FirebaseException ? error.message : error.toString(),
      ),
    );
  }

  Future<void> _onLoadProductById(
    GetProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => ProductStatus.loading,
        errorMessage: () => null,
      ),
    );
    try {
      final cartProduct = await Future.wait(
        event.cartItem.map((e) async {
          final product = await _productRepository.getProductById(e.productId);
          if (product != null) {
            return CartProduct(
              product: product,
              quantity: e.quantity.toString(),
              subtotal: e.subtotal.toString(),
            );
          } else {
            return null;
          }
        }),
      );
      Map<String, List<CartProduct>> validCartProducts = {};
      validCartProducts[event.id] = cartProduct
          .whereType<CartProduct>()
          .toList();
      emit(
        state.copyWith(
          cartProduct: () => validCartProducts,
          status: () => ProductStatus.success,
          errorMessage: () => null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: () => ProductStatus.failure,
          errorMessage: () =>
              error is FirebaseException ? error.message : error.toString(),
        ),
      );
    }
  }
}
