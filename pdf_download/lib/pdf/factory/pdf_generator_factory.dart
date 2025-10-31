import 'package:pdf_download/pdf/pdf_generator.dart';

abstract interface class PdfGeneratorFactory {
  PdfGenerator createPdfGenerator();
}