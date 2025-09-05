import 'dart:async';

import 'package:admin_shop/models/order_model.dart';
import 'package:admin_shop/repositories/orders/iorder_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
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
    on<SetStatusCodeRequested>(_onSetStatusCodeRequested);
  }

  Future<void> _onOrdersOverviewSubscriptionRequested(
    OrdersOverviewSubscriptionRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: () => OrdersOverviewStatus.loading));
    await emit.forEach<List<OrderModel>?>(
      _orderRepository.orderStream,
      onData: (data) {
        if (data == null) return OrderState.initial();
        final count = <String, int>{};
        final totalSpent = <String, num>{};
        for (final order in data) {
          count[order.userId] = (count[order.userId] ?? 0) + 1;
          totalSpent[order.userId] =
              (Decimal.parse((totalSpent[order.userId] ?? 0).toString()) +
                      Decimal.parse(order.total.toString()))
                  .round(scale: 2)
                  .toDouble();
        }
        return state.copyWith(
          orders: () => data,
          status: () => OrdersOverviewStatus.success,
          userOrdersCount: () => count,
          userOrdersTotal: () => totalSpent,
        );
      },
      onError: (error, _) => state.copyWith(
        status: () => OrdersOverviewStatus.failure,
        orderError: () => error is FirebaseException
            ? (error.message ?? 'Firebase unknown error!')
            : error.toString(),
      ),
    );
  }

  Future<void> _onSetStatusCodeRequested(
    SetStatusCodeRequested event,
    Emitter<OrderState> emit,
  ) async {
    try {
      await _orderRepository.setStatusCode(event.oid, event.isIncrement);
      emit(state.copyWith(status: () => OrdersOverviewStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          orderError: () => e is FirebaseException
              ? (e.message ?? 'Firebase unknown error!')
              : e.toString(),
        ),
      );
    }
  }
}
