import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

final class PdfBuilder {
  static Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: <pw.Widget>[
                pw.Text(
                  'Hello, Flutter PDF!',
                  style: pw.TextStyle(fontSize: 40),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'This is a sample PDF document generated in Flutter.',
                  style: pw.TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
