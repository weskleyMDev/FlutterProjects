import 'package:pdf_download/pdf/factory/pdf_generator_factory.dart';
import 'package:pdf_download/pdf/factory/web_pdf_generator_factory.dart';

final class PdfGeneratorFactoryProvider {
  static PdfGeneratorFactory getFactory() {
    return WebPdfGeneratorFactory.instance;
  }
}
