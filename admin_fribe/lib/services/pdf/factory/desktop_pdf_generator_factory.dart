import 'package:admin_fribe/services/pdf/desktop_pdf_generator.dart';
import 'package:admin_fribe/services/pdf/factory/pdf_generator_factory.dart';
import 'package:admin_fribe/services/pdf/pdf_generator.dart';

final class DesktopPdfGeneratorFactory implements PdfGeneratorFactory {
  static DesktopPdfGeneratorFactory? _instance;
  DesktopPdfGeneratorFactory._internal();
  static DesktopPdfGeneratorFactory get instance =>
      _instance ??= DesktopPdfGeneratorFactory._internal();
  @override
  PdfGenerator createPdfGenerator() => DesktopPdfGenerator();
}
