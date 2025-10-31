import 'dart:io';

import 'package:pdf_download/pdf/factory/desktop_pdf_generator_factory.dart';
import 'package:pdf_download/pdf/factory/mobile_pdf_generator_factory.dart';
import 'package:pdf_download/pdf/factory/pdf_generator_factory.dart';

final class PdfGeneratorFactoryProvider {
  static PdfGeneratorFactory getFactory() {
    if (Platform.isAndroid || Platform.isIOS) {
      return MobilePdfGeneratorFactory.instance;
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return DesktopPdfGeneratorFactory.instance;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
