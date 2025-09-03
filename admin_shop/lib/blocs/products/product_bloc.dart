import 'dart:async';

import 'package:admin_shop/models/product_model.dart';
import 'package:admin_shop/repositories/products/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'product_event.dart';
part 'product_state.dart';

final class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductState.initial()) {
    on<ProductsOverviewSubscriptionRequested>(
      _onProductsOverviewSubscriptionRequested,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  Future<void> _onProductsOverviewSubscriptionRequested(
    ProductsOverviewSubscriptionRequested event,
    Emitter<ProductState> emit,
  ) async {
    final category = event.category;
    emit(
      state.copyWith(
        statusByCategory: () => {
          ...state.statusByCategory,
          category: ProductStateStatus.waiting,
        },
      ),
    );
    await emit.forEach<List<ProductModel>>(
      _productRepository.fetchDataFromFirestore(category),
      onData: (data) => state.copyWith(
        productsByCategory: () => {...state.productsByCategory, category: data},
        statusByCategory: () => {
          ...state.statusByCategory,
          category: ProductStateStatus.success,
        },
      ),
      onError: (e, _) => state.copyWith(
        statusByCategory: () => {
          ...state.statusByCategory,
          category: ProductStateStatus.error,
        },
        errorMessage: () => {
          ...state.errorMessage,
          category: e is FirebaseException
              ? e.message ?? 'Firestore Unknown Error!'
              : e.toString(),
        },
      ),
    );
  }
}
