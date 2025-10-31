import 'package:admin_fribe/services/pdf/pdf_generator.dart';

abstract interface class PdfGeneratorFactory {
  PdfGenerator createPdfGenerator();
}