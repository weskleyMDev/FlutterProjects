import 'package:admin_fribe/services/pdf/factory/pdf_generator_factory.dart';
import 'package:admin_fribe/services/pdf/mobile_pdf_generator.dart';
import 'package:admin_fribe/services/pdf/pdf_generator.dart';

final class MobilePdfGeneratorFactory implements PdfGeneratorFactory {
  static MobilePdfGeneratorFactory? _instance;
  MobilePdfGeneratorFactory._internal();
  static MobilePdfGeneratorFactory get instance =>
      _instance ??= MobilePdfGeneratorFactory._internal();
  @override
  PdfGenerator createPdfGenerator() => MobilePdfGenerator();
}
