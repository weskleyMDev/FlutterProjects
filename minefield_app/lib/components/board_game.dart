import 'package:flutter/material.dart';
import 'package:minefield_app/components/field_game.dart';
import 'package:minefield_app/models/field.dart';
import 'package:minefield_app/models/game_board.dart';

class BoardGame extends StatelessWidget {
  const BoardGame({
    super.key,
    required this.gameBoard,
    required this.onOpen,
    required this.onSwitchMark,
  });

  final GameBoard gameBoard;
  final void Function(Field) onOpen;
  final void Function(Field) onSwitchMark;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: gameBoard.columns,
      children: gameBoard.fields
          .map(
            (c) => FieldGame(
              field: c,
              onOpen: onOpen,
              onSwitchMark: onSwitchMark,
            ),
          )
          .toList(),
    );
  }
}
