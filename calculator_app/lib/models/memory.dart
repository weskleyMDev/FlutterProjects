import 'package:decimal/decimal.dart';

class Memory {
  static const operations = ['%', '+', '-', 'x', '/', '='];
  final _buffer = [Decimal.zero, Decimal.zero];
  int _bufferIndex = 0;
  String? _operation;
  String _text = '';
  bool _wipeText = false;
  String? _lastOperation;

  String get text => _text;

  void applyCommand(String text) {
    if (_isReplaceOperation(operation: text)) {
      _operation = text;
      return;
    }
    if (text == 'AC') {
      _allClear();
    } else if (operations.contains(text)) {
      _setOperation(text);
    } else {
      _addDigit(text);
    }
    _lastOperation = text;
  }

  _isReplaceOperation({required String operation}) {
    return operations.contains(_lastOperation) &&
        operations.contains(operation) &&
        _lastOperation != '=' &&
        operation != '=';
  }

  void _allClear() {
    _text = '';
    _buffer.setAll(0, [Decimal.zero, Decimal.zero]);
    _operation = null;
    _bufferIndex = 0;
    _wipeText = false;
  }

  _addDigit(String text) {
    final isDot = text == '.';
    if (isDot && _text.contains('.') && !_wipeText) return;
    final shouldReplace = (_text == '' && !isDot) || _wipeText;
    final willBeDotOnly = (isDot && (shouldReplace || _text == ''));

    final prefix = willBeDotOnly ? '0' : (shouldReplace ? '' : _text);
    _text = prefix + text;
    _wipeText = false;

    _buffer[_bufferIndex] = Decimal.tryParse(_text) ?? Decimal.zero;
  }

  _setOperation(String newOperation) {
    bool isFinalResult = newOperation == '=';
    if (_bufferIndex == 0) {
      if (!isFinalResult) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeText = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = Decimal.zero;
      _text = _buffer[0].toString();
      _operation = isFinalResult ? null : newOperation;
      _bufferIndex = isFinalResult ? 0 : 1;
    }
    _wipeText = true; // !isFinalResult;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      default:
        return _buffer[0];
    }
  }
}
