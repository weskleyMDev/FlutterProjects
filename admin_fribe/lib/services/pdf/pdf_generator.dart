import 'dart:typed_data';

abstract interface class PdfGenerator {
  Future<void> generatePdf(Uint8List pdfData, String fileName);
}
