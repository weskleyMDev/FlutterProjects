part of 'pdf_generator_bloc.dart';

sealed class PdfGeneratorEvent extends Equatable {
  const PdfGeneratorEvent();

  @override
  List<Object> get props => [];
}

final class GeneratePdfEvent extends PdfGeneratorEvent {
  const GeneratePdfEvent({
    required this.fileName,
  });
  final String fileName;

  @override
  List<Object> get props => [fileName];
}
