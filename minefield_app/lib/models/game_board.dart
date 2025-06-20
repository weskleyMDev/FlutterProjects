import 'dart:math';

import 'package:minefield_app/models/field.dart';

class GameBoard {
  final int lines;
  final int columns;
  final int amountBombs;

  final List<Field> _fields = [];

  GameBoard({
    required this.lines,
    required this.columns,
    required this.amountBombs,
  }) {
    _createFields();
    _relateNeighbors();
    _spreadMines();
  }

  void reset() {
    for (var field in _fields) {
      field.reset();
    }
    _spreadMines();
  }

  void showBombs() {
    for (var field in _fields) {
      field.showBomb();
    }
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _relateNeighbors() {
    for (var field in _fields) {
      final neighbors = _getNeighbors(field);
      for (var neighbor in neighbors) {
        field.addNeighbor(neighbor);
      }
    }
  }

  List<Field> _getNeighbors(Field field) {
    List<Field> neighbors = [];
    for (int l = field.line - 1; l <= field.line + 1; l++) {
      for (int c = field.column - 1; c <= field.column + 1; c++) {
        if (l >= 0 &&
            l < lines &&
            c >= 0 &&
            c < columns &&
            !(l == field.line && c == field.column)) {
          neighbors.add(
            _fields.firstWhere((f) => f.line == l && f.column == c),
          );
        }
      }
    }
    return neighbors;
  }

  void _spreadMines() {
    int minesPlaced = 0;
    if (amountBombs > lines * columns) return;
    while (minesPlaced < amountBombs) {
      int i = Random().nextInt(_fields.length);
      if (!_fields[i].isMined) {
        _fields[i].mine();
        minesPlaced++;
      }
    }
  }

  List<Field> get fields => _fields;

  bool get isGameOver => _fields.every((f) => f.solved);
}
