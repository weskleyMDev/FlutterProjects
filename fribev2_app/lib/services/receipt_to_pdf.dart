import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

import '../models/sales_receipt.dart';

class ReceiptGenerator {
  Future<void> generateReceipt({required SalesReceipt? receipt}) async {
    final receiveId = receipt?.id ?? Uuid().v4();
    final directory = await getApplicationDocumentsDirectory();

    final recibosDir = Directory('${directory.path}/Recibos');

    if (!await recibosDir.exists()) {
      await recibosDir.create(recursive: true);
    }

    final pdfFile = File('${recibosDir.path}/$receiveId.pdf');

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
                        pw.ListView.builder(
                          itemCount: receiptProducts.length,
                          itemBuilder: (context, index) {
                            final item = receiptProducts[index];
                            return pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  '${item.product?.name ?? ''} x${item.quantity.toString().replaceAll('.', ',')}',
                                ),
                                // pw.Text(
                                //   'R\$ ${item.subtotal.replaceAll('.', ',')}',
                                // ),
                              ],
                            );
                          },
                        ),
                        pw.SizedBox(height: 20),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Total: R\$ ${receipt?.total.replaceAll('.', ',')}',
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
                  pw.ListView.builder(
                    itemCount: receipt?.payments.length ?? 0,
                    itemBuilder: (context, index) {
                      final payment = receipt?.payments[index];
                      final String type = payment?.type ?? 'Unknown';
                      final String value = payment?.value ?? '0';
                      return pw.Row(
                        children: [
                          pw.Text(
                            '$type: ',
                            style: pw.TextStyle(fontSize: 12.0),
                          ),
                          pw.Text(
                            'R\$ ${double.parse(value).toStringAsFixed(2).replaceAll('.', ',')}',
                            style: pw.TextStyle(fontSize: 12.0),
                          ),
                        ],
                      );
                    },
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

    await pdfFile.writeAsBytes(await pdf.save());
  }
}
