import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/widgets/sales_receipt_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReceiptBloc, SalesReceiptState>(
      builder: (context, state) {
        if (state.salesStatus == SalesReceiptStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.salesStatus == SalesReceiptStatus.failure) {
          return Center(child: Text('Error: ${state.salesErrorMessage}'));
        } else if (state.salesStatus == SalesReceiptStatus.success) {
          final salesReceipts = state.salesReceipts;
          if (salesReceipts.isEmpty) {
            return const Center(child: Text('No sales receipts found.'));
          }
          return ListView.builder(
            itemCount: salesReceipts.length,
            itemBuilder: (context, index) {
              final receipt = salesReceipts[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SalesReceiptTile(receipt: receipt),
                ),
              );
            },
          );
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
  }
}
