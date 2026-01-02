import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/widgets/build_receipt_list.dart';
import 'package:admin_fribe/widgets/select_date_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receiptState = context.watch<SalesReceiptBloc>().state;

    Future<void> selectDate(BuildContext context, bool isStartDate) async {
      final now = DateTime.now();
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2024),
        lastDate: now.add(const Duration(days: 365)),
      );
      if (picked != null) {
        final DateTime adjustedDate = isStartDate
            ? DateTime(picked.year, picked.month, picked.day)
            : DateTime(
                picked.year,
                picked.month,
                picked.day,
              ).add(const Duration(days: 1));

        if (!context.mounted) return;
        if (isStartDate) {
          context.read<SalesReceiptBloc>().add(StartDateChanged(adjustedDate));
        } else {
          context.read<SalesReceiptBloc>().add(EndDateChanged(adjustedDate));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SelectDateCard(
          title: 'Start Date',
          subtitle: receiptState.startDateFormatted,
          tooltip: 'Select Start Date',
          selectDate: () => selectDate(context, true),
          iconColor: Colors.green,
        ),
        SelectDateCard(
          title: 'End Date',
          subtitle: receiptState.endDateFormatted,
          tooltip: 'Select End Date',
          selectDate: () => selectDate(context, false),
          iconColor: Colors.red,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: receiptState.canFetchSalesReceipts
                ? () => context.read<SalesReceiptBloc>().add(
                    const LoadSalesReceipts(),
                  )
                : null,
            child: const Text('Carregar Recibos'),
          ),
        ),
        Expanded(child: BuildReceiptList(receiptState: receiptState)),
      ],
    );
  }
}
