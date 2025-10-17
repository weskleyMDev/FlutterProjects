part of 'update_amount_bloc.dart';

final class UpdateAmountState extends Equatable {
  const UpdateAmountState._({
    required this.amountInput,
    required this.submissionStatus,
    required this.errorMessage,
  });

  final AmountInput amountInput;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  factory UpdateAmountState.initial() => UpdateAmountState._(
    amountInput: const AmountInput.pure(),
    submissionStatus: FormzSubmissionStatus.initial,
    errorMessage: null,
  );

  UpdateAmountState copyWith({
    AmountInput? amountInput,
    FormzSubmissionStatus? submissionStatus,
    String? Function()? errorMessage,
  }) {
    return UpdateAmountState._(
      amountInput: amountInput ?? this.amountInput,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  bool get isValid => Formz.validate([amountInput]);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [amountInput, submissionStatus, errorMessage];
}
