import 'package:formz/formz.dart';

enum SizesInputError { empty }

enum SizesFilter { p, m, g }

final class SizesInput extends FormzInput<Set<SizesFilter>, SizesInputError> {
  const SizesInput.pure() : super.pure(const {});
  const SizesInput.dirty([super.value = const {}]) : super.dirty();

  @override
  SizesInputError? validator(Set<SizesFilter> value) {
    return value.isNotEmpty ? null : SizesInputError.empty;
  }
}
