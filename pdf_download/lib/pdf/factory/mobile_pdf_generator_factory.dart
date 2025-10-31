import 'package:pdf_download/pdf/factory/pdf_generator_factory.dart';
import 'package:pdf_download/pdf/mobile_pdf_generator.dart';
import 'package:pdf_download/pdf/pdf_generator.dart';

final class MobilePdfGeneratorFactory implements PdfGeneratorFactory {
  static MobilePdfGeneratorFactory? _instance;
  MobilePdfGeneratorFactory._internal();
  static MobilePdfGeneratorFactory get instance =>
      _instance ??= MobilePdfGeneratorFactory._internal();

  @override
  PdfGenerator createPdfGenerator() => MobilePdfGenerator();
}
