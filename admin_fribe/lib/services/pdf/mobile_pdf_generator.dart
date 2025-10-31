import 'dart:typed_data';

import 'package:admin_fribe/services/pdf/pdf_generator.dart';
import 'package:printing/printing.dart';

final class MobilePdfGenerator implements PdfGenerator {
  @override
  Future<void> generatePdf(Uint8List pdfData, String fileName) async {
    await Printing.sharePdf(bytes: pdfData, filename: fileName);
  }
}
