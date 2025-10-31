import 'package:pdf_download/pdf/factory/pdf_generator_factory.dart';
import 'package:pdf_download/pdf/pdf_generator.dart';
import 'package:pdf_download/pdf/web_pdf_generator.dart';

final class WebPdfGeneratorFactory implements PdfGeneratorFactory {
  static WebPdfGeneratorFactory? _instance;
  WebPdfGeneratorFactory._internal();
  static WebPdfGeneratorFactory get instance =>
      _instance ??= WebPdfGeneratorFactory._internal();
  @override
  PdfGenerator createPdfGenerator() => WebPdfGenerator();
}
