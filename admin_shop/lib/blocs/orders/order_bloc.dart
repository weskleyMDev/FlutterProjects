import 'dart:async';

import 'package:admin_shop/models/order_model.dart';
import 'package:admin_shop/repositories/orders/iorder_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

final class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderRepository _orderRepository;

  OrderBloc(this._orderRepository) : super(OrderState.initial()) {
    on<OrdersOverviewSubscriptionRequested>(
      _onOrdersOverviewSubscriptionRequested,
    );
    on<UserOrdersCountRequested>(_onUserOrdersCountRequested);
    on<UserOrdersTotalRequested>(_onUserOrdersTotalRequested);
  }

  Future<void> _onOrdersOverviewSubscriptionRequested(
    OrdersOverviewSubscriptionRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderState.loading(orders: state.orders));
    await emit.forEach<List<OrderModel>?>(
      _orderRepository.orderStream,
      onData: (data) =>
          data != null ? OrderState.success(data) : OrderState.initial(),
      onError: (error, _) => OrderState.failure(
        error is FirebaseException
            ? (error.message ?? 'Firebase unknown error!')
            : error.toString(),
      ),
    );
  }

  Future<void> _onUserOrdersCountRequested(
    UserOrdersCountRequested event,
    Emitter<OrderState> emit,
  ) async {
    await emit.forEach<int>(
      _orderRepository.getUserOrdersCount(event.userId),
      onData: (counter) {
        final updatedCount = Map<String, int>.from(state.userOrdersCount);
        updatedCount[event.userId] = counter;
        return state.copyWith(userOrdersCount: () => updatedCount);
      },
      onError: (error, _) => OrderState.failure(
        error is FirebaseException
            ? (error.message ?? 'Firebase unknown error!')
            : error.toString(),
      ),
    );
  }

  Future<void> _onUserOrdersTotalRequested(
    UserOrdersTotalRequested event,
    Emitter<OrderState> emit,
  ) async {
    await emit.forEach<double>(
      _orderRepository.getUserTotalOrders(event.userId),
      onData: (total) {
        final updatedTotal = Map<String, double>.from(state.userOrdersTotal);
        updatedTotal[event.userId] = total;
        return state.copyWith(userOrdersTotal: () => updatedTotal);
      },
      onError: (error, _) => OrderState.failure(
        error is FirebaseException
            ? (error.message ?? 'Firebase unknown error!')
            : error.toString(),
      ),
    );
  }
}
