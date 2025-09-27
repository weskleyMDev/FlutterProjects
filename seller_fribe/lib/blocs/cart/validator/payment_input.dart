import 'package:formz/formz.dart';

enum PaymentInputError { empty, invalid, exceedsTotal, negative, zero }

final class PaymentInput extends FormzInput<String, PaymentInputError> {
  const PaymentInput.pure() : super.pure('');
  const PaymentInput.dirty([super.value = '']) : super.dirty();

  static double _total = 0.0;

  static void setPaymentTotal(double total) {
    _total = total;
  }

  static final _paymentRegex = RegExp(r'^-?(0|[1-9]\d*)([.,]\d{1,2})?$');

  @override
  PaymentInputError? validator(String value) {
    if (value.isEmpty) return PaymentInputError.empty;
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || !_paymentRegex.hasMatch(value)) {
      return PaymentInputError.invalid;
    }
    if (parsed < 0) return PaymentInputError.negative;
    if (parsed == 0) return PaymentInputError.zero;
    if (parsed > _total) return PaymentInputError.exceedsTotal;
    return null;
  }
}
