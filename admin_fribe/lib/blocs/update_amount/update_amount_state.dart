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

  String? _getErrorText<T extends Enum>(
    FormzInput input,
    Map<T, String> messages,
  ) {
    if (input.isPure || input.error == null) return null;
    return messages[input.error as T];
  }

  String? get amountErrorText => _getErrorText<AmountInputError>(amountInput, {
    AmountInputError.empty: 'Amount cannot be empty',
    AmountInputError.invalid: 'Invalid amount format',
    AmountInputError.negative: 'Amount cannot be negative',
    AmountInputError.zero: 'Amount must be greater than zero',
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [amountInput, submissionStatus, errorMessage];
}
