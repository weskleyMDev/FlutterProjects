import 'package:admin_fribe/blocs/update_amount/validator/amount_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AmountInput', () {

    test('should be valid with positive integer', () {
      const input = AmountInput.dirty('5');

      expect(input.isValid, true);
      expect(input.error, null);
    });


    test('should be valid with up to three decimal places', () {
      const input = AmountInput.dirty('10.123');

      expect(input.isValid, true);
      expect(input.error, null);
    });


    test('should be invalid when empty', () {
      const input = AmountInput.dirty('');

      expect(input.isValid, false);
      expect(input.error, AmountInputError.empty);
    });


    test('should be invalid when value is not numeric', () {
      const input = AmountInput.dirty('abc');

      expect(input.isValid, false);
      expect(input.error, AmountInputError.invalid);
    });


    test('should be invalid when value is negative', () {
      const input = AmountInput.dirty('-5');

      expect(input.isValid, false);
      expect(input.error, AmountInputError.negative);
    });


    test('should be invalid when value is zero', () {
      const input = AmountInput.dirty('0');

      expect(input.isValid, false);
      expect(input.error, AmountInputError.zero);
    });


    test('should be invalid with more than three decimal places', () {
      const input = AmountInput.dirty('10.1234');

      expect(input.isValid, false);
      expect(input.error, AmountInputError.invalid);
    });

  });
}