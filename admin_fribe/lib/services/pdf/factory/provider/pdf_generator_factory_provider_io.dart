import 'dart:io';

import 'package:admin_fribe/services/pdf/factory/desktop_pdf_generator_factory.dart';
import 'package:admin_fribe/services/pdf/factory/mobile_pdf_generator_factory.dart';
import 'package:admin_fribe/services/pdf/factory/pdf_generator_factory.dart';

final class PdfGeneratorFactoryProvider {
  static PdfGeneratorFactory getFactory() {
    if (Platform.isAndroid || Platform.isIOS) {
      return MobilePdfGeneratorFactory.instance;
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return DesktopPdfGeneratorFactory.instance;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
