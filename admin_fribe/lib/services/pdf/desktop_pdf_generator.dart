import 'dart:io';
import 'dart:typed_data';

import 'package:admin_fribe/services/pdf/pdf_generator.dart';
import 'package:path_provider/path_provider.dart';

final class DesktopPdfGenerator implements PdfGenerator {
  @override
  Future<void> generatePdf(Uint8List pdfData, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileDir = Directory('${directory.path}/PDFs');
    if (!await fileDir.exists()) {
      await fileDir.create(recursive: true);
    }
    final file = File('${fileDir.path}/$fileName');
    await file.writeAsBytes(pdfData);
  }
}
