import 'package:formz/formz.dart';

enum ImageUrlInputError { empty, invalid }

final class ImageUrlInput extends FormzInput<String, ImageUrlInputError> {
  const ImageUrlInput.pure() : super.pure('');
  const ImageUrlInput.dirty([super.value = '']) : super.dirty();

  static final _urlRegExp = RegExp(
    r'^https?:\/\/[^\s\/$.?#].[^\s]*\.(png|jpg|jpeg|svg|webp|gif|bmp|tiff|ico)$',
  );

  @override
  ImageUrlInputError? validator(String value) {
    if (value.isEmpty) {
      return ImageUrlInputError.empty;
    }
    if (!_urlRegExp.hasMatch(value)) {
      return ImageUrlInputError.invalid;
    }
    return null;
  }
}
