import 'package:formz/formz.dart';

enum SearchInputError { empty }

final class SearchInput extends FormzInput<String, SearchInputError> {
  const SearchInput.pure() : super.pure('');
  const SearchInput.dirty([super.value = '']) : super.dirty();

  @override
  SearchInputError? validator(String value) {
    return value.isNotEmpty ? null : SearchInputError.empty;
  }
}
