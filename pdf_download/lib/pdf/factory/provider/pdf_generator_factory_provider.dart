export 'pdf_generator_factory_provider_stub.dart'
    if (dart.library.html) 'pdf_generator_factory_provider_web.dart'
    if (dart.library.io) 'pdf_generator_factory_provider_io.dart';

