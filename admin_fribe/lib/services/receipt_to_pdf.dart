import 'dart:io';

import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptToPdfService {
  static Future<void> convertReceiptToPdf(
    SalesReceipt receipt,
    BuildContext context,
  ) async {
    final receiptId = receipt.id;
    final directory = await getApplicationDocumentsDirectory();
    final receiptDir = Directory('${directory.path}/Receipts');
    if (!await receiptDir.exists()) {
      await receiptDir.create(recursive: true);
    }
    final filePath = '${receiptDir.path}/$receiptId.pdf';
    final pdfFile = File(filePath);
    final receiptProducts = receipt.cart;
    if (!context.mounted) return;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final currency = NumberFormat.simpleCurrency(locale: locale);
    final numberFormat = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: 3,
    );
    final products = BlocProvider.of<ProductBloc>(context).state.products;
    final date = DateFormat('dd/MM/yyyy').add_Hm().format(receipt.createAt);
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
                  pw.Text('Cod: $receiptId'),
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
                            final product = products.firstWhere(
                              (prod) => prod?.id == item.productId,
                              orElse: () => ProductModel.empty(),
                            );
                            return pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  '${product?.name ?? ''} x${numberFormat.format(item.quantity)}',
                                ),
                                pw.Text(currency.format(item.subtotal)),
                              ],
                            );
                          },
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Desconto:'),
                            pw.Text(
                              currency.format(
                                double.tryParse(receipt.discount) ?? 0,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Frete:'),
                            pw.Text(
                              currency.format(
                                double.tryParse(receipt.shipping) ?? 0,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Juros:'),
                            pw.Text(
                              currency.format(
                                double.tryParse(receipt.tariffs) ?? 0,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 20),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Total: ${currency.format(double.tryParse(receipt.total) ?? 0)}',
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
                    itemCount: receipt.payments.length,
                    itemBuilder: (context, index) {
                      final payment = receipt.payments[index];
                      final String type = payment.type;
                      final String value = payment.value;
                      return pw.Row(
                        children: [
                          pw.Text(
                            '$type: ',
                            style: pw.TextStyle(fontSize: 12.0),
                          ),
                          pw.Text(
                            currency.format(double.tryParse(value) ?? 0),
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
