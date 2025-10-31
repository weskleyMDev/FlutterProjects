import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_download/pdf/factory/provider/pdf_generator_factory_provider.dart';
import 'package:pdf_download/service/pdf_builder.dart';

part 'pdf_generator_event.dart';
part 'pdf_generator_state.dart';

class PdfGeneratorBloc extends Bloc<PdfGeneratorEvent, PdfGeneratorState> {
  PdfGeneratorBloc() : super(PdfGeneratorState.initial()) {
    on<GeneratePdfEvent>(_onGeneratePdfEvent);
  }

  Future<void> _onGeneratePdfEvent(
    GeneratePdfEvent event,
    Emitter<PdfGeneratorState> emit,
  ) async {
    emit(
      PdfGeneratorState._(
        status: PdfGeneratorStatus.generating,
        errorMessage: null,
      ),
    );

    try {
      final pdfFactory = PdfGeneratorFactoryProvider.getFactory();
      final generator = pdfFactory.createPdfGenerator();

      await generator.generatePdf(
        await PdfBuilder.generatePdf(),
        event.fileName,
      );

      emit(
        PdfGeneratorState._(
          status: PdfGeneratorStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        PdfGeneratorState._(
          status: PdfGeneratorStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
