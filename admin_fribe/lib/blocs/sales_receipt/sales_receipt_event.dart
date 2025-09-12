part of 'sales_receipt_bloc.dart';

sealed class SalesReceiptEvent extends Equatable {
  const SalesReceiptEvent();
  @override
  List<Object> get props => [];
}

final class LoadSalesReceipts extends SalesReceiptEvent {
  const LoadSalesReceipts();
  
  @override
  List<Object> get props => [];
}
