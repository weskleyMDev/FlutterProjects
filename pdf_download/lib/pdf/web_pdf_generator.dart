import 'dart:js_interop';
import 'dart:typed_data';

import 'package:pdf_download/pdf/pdf_generator.dart';
import 'package:web/web.dart' as web;

final class WebPdfGenerator implements PdfGenerator {
  @override
  Future<void> generatePdf(Uint8List pdfData, String fileName) async {
    final blob = web.Blob([pdfData.toJS].toJS);
    final url = web.URL.createObjectURL(blob);
    final _ = web.HTMLAnchorElement()
      ..href = url
      ..download = fileName
      ..click();
    web.URL.revokeObjectURL(url);
  }
}
