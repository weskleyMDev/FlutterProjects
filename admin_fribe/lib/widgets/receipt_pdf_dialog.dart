import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/services/pdf/receipt_to_pdf.dart';
import 'package:flutter/material.dart';

class ReceiptPdfDialog extends StatelessWidget {
  const ReceiptPdfDialog({super.key, required this.receipt});

  final SalesReceipt receipt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deseja salvar o recibo em PDF?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            await ReceiptToPdfService.convertReceiptToPdf(receipt, context);
            if (!context.mounted) return;
            Navigator.of(context).pop(true);
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
