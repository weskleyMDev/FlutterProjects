import 'package:diacritic/diacritic.dart';
import 'package:formz/formz.dart';

enum PendingSaleInputError { empty, invalid }

final class PendingSaleInput extends FormzInput<String, PendingSaleInputError> {
  const PendingSaleInput.pure() : super.pure('');
  const PendingSaleInput.dirty([super.value = '']) : super.dirty();

  static final _pendingSaleRegexp = RegExp(r'^[a-zA-Z0-9_]+$');

  String get normalizedValue => _normalize(value);

  @override
  PendingSaleInputError? validator(String value) {
    final cleaned = _normalize(value);
    if (cleaned.isEmpty) {
      return PendingSaleInputError.empty;
    }
    if (!_pendingSaleRegexp.hasMatch(cleaned)) {
      return PendingSaleInputError.invalid;
    }
    return null;
  }

  static String _normalize(String input) {
    return removeDiacritics(
      input.trim(),
    ).toLowerCase().replaceAll(RegExp(r'\s+'), '_');
  }
}
