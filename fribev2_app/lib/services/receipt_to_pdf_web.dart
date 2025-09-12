import 'dart:html' as html;
import 'dart:js_util' as js_util;

import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

import '../models/sales_receipt.dart';

class ReceiptGeneratorWeb {
  Future<void> generateReceiptWeb({required SalesReceipt? receipt}) async {
    final receiveId = receipt?.id ?? Uuid().v4();

    final receiptProducts = receipt?.cart ?? [];
    final date = DateFormat(
      'dd/MM/y - HH:mm',
    ).format(receipt?.createAt ?? DateTime.now());

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.SizedBox(
              width: 320.0,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Recibo de Pagamento',
                    style: pw.TextStyle(fontSize: 24),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Fribe Cortes Especiais',
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.SizedBox(height: 10.0),
                  pw.Text('Codigo: $receiveId'),
                  pw.Text(date),
                  pw.SizedBox(height: 20),
                  pw.Text('-' * 80),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(vertical: 8.0),
                    child: pw.Column(
                      children: [
                        for (var item in receiptProducts)
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Text(
                                '${item.product?.name ?? ''} x${item.quantity.toString().replaceAll('.', ',')}',
                              ),
                              pw.Text(
                                'R\$ ${item.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                              ),
                            ],
                          ),
                        pw.SizedBox(height: 20),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Total: R\$ ${double.parse(receipt!.total).toStringAsFixed(2).replaceAll('.', ',')}',
                              style: pw.TextStyle(
                                fontSize: 14.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Text('-' * 80),
                  pw.SizedBox(height: 20),
                  for (var payment in receipt.payments)
                    pw.Row(
                      children: [
                        pw.Text(
                          '${payment.type}: ',
                          style: pw.TextStyle(fontSize: 12.0),
                        ),
                        pw.Text(
                          'R\$ ${double.parse(payment.value).toStringAsFixed(2).replaceAll('.', ',')}',
                          style: pw.TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  pw.SizedBox(height: 50),
                  pw.Text(
                    'Obrigado pela preferência!',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();

    js_util.jsify(pdfBytes);

    final blob = html.Blob([pdfBytes]);

    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement()
      ..href = url
      ..target = '_blank'
      ..download = '$receiveId.pdf';

    anchor.click();

    html.Url.revokeObjectUrl(url);
  }
}
