class Memory {
  static const operations = ['%', '+', '-', 'x', '/', '='];
  final _buffer = [0.0, 0.0];
  final int _bufferIndex = 0;
  String _text = '';
  bool _wipeText = false;

  String get text => _text;

  void applyCommand(String text) {
    if (text == 'AC') {
      _allClear();
    } else if (operations.contains(text)) {
      _setOperation(text);
    } else {
      _addDigit(text);
    }
  }

  void _allClear() => _text = '';

  _addDigit(String text) {
    final isDot = text == '.';
    if (isDot && _text.contains('.') && !_wipeText) return;
    final shouldReplace = (_text == '' && !isDot) || _wipeText;
    final willBeDotOnly = (isDot && (shouldReplace || _text == ''));

    final prefix = willBeDotOnly ? '0' : (shouldReplace ? '' : _text);
    _text = prefix + text;
    _wipeText = false;
  }

  _setOperation(String newOperation) {
    _wipeText = true;
  }
}
