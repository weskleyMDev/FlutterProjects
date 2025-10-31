import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf_download/pdf/pdf_generator.dart';

final class DesktopPdfGenerator implements PdfGenerator {
  @override
  Future<void> generatePdf(Uint8List pdfData, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileDir = Directory('${directory.path}/PDFs');
    if (!await fileDir.exists()) {
      await fileDir.create(recursive: true);
    }
    final filePath = '${fileDir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
  }
}
