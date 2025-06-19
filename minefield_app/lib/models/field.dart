import 'package:minefield_app/exceptions/explosion.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _open = false;
  bool _mark = false;
  bool _mined = false;
  bool _burst = false;

  Field({required this.line, required this.column});

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) return;

    if (deltaLine <= 1 && deltaColumn <= 1) neighbors.add(neighbor);
  }

  void open() {
    if (_open) return;

    _open = true;

    if (_mined) {
      _burst = true;
      throw Explosion();
    }

    if (safeNeighborhood) {
      for (var n in neighbors) {
        n.open();
      }
    }
  }

  void showBomb() {
    if (_mined) _open = true;
  }

  void mine() => _mined = true;

  void switchMark() => _mark = !_mark;

  void reset() {
    _open = false;
    _mark = false;
    _mined = false;
    _burst = false;
  }

  bool get isOpened => _open;
  bool get isMarked => _mark;
  bool get isMined => _mined;
  bool get isBursted => _burst;

  bool get solved {
    bool minedAndMarked = isMined && isMarked;
    bool safedAndOpened = !isMined && isOpened;
    return minedAndMarked || safedAndOpened;
  }

  bool get safeNeighborhood => neighbors.every((n) => !n._mined);

  int get manyMinesInNeighborhood => neighbors.where((n) => n.isMined).length;
}
