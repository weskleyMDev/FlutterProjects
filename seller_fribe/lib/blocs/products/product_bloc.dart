import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/blocs/products/validator/search_input.dart';
import 'package:seller_fribe/models/cart_item_model.dart';
import 'package:seller_fribe/models/product_model.dart';
import 'package:seller_fribe/repositories/products/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

final class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _productRepository;
  ProductBloc({required IProductRepository productRepository})
    : _productRepository = productRepository,
      super(const ProductState.initial()) {
    on<ProductSubscribeRequested>(_onProductSubscribeRequested);
    on<ProductSearchQueryChanged>(_onProductSearchQueryChanged);
    on<ProductUpdateAmountRequested>(_onProductUpdateAmountRequested);
  }

  Future<void> _onProductSubscribeRequested(
    ProductSubscribeRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.withLoading());
    try {
      await emit.forEach<List<ProductModel>?>(
        _productRepository.productFromFirebase,
        onData: (products) {
          if (products == null) {
            return state.withFailure("No products found.");
          }
          return state.withSuccess(products);
        },
        onError: (e, _) => e is FirebaseException
            ? state.withFailure(e.message)
            : state.withFailure(e.toString()),
      );
    } catch (e) {
      emit(state.withFailure(e.toString()));
    }
  }

  Future<void> _onProductUpdateAmountRequested(
    ProductUpdateAmountRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.withLoading());
    try {
      final futures = event.cartItems.map((cartItem) {
        return _productRepository.updateAmountProduct(
          cartItem.productId,
          cartItem.quantity.toString(),
        );
      }).toList();
      await Future.wait(futures);
      emit(state.withSuccess(state.allProducts));
    } catch (e) {
      emit(state.withFailure(e.toString()));
    }
  }

  FutureOr<void> _onProductSearchQueryChanged(
    ProductSearchQueryChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.withSearch(event.query));
  }
}
