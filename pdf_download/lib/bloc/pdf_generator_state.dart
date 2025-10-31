part of 'pdf_generator_bloc.dart';

enum PdfGeneratorStatus { initial, generating, success, failure }

final class PdfGeneratorState extends Equatable {
  const PdfGeneratorState._({required this.status, required this.errorMessage});

  factory PdfGeneratorState.initial() => const PdfGeneratorState._(
    status: PdfGeneratorStatus.initial,
    errorMessage: null,
  );

  final PdfGeneratorStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
}
