import 'package:flutter/material.dart';
import 'package:minefield_app/components/board_game.dart';
import 'package:minefield_app/components/result_game.dart';
import 'package:minefield_app/exceptions/explosion.dart';
import 'package:minefield_app/models/field.dart';
import 'package:minefield_app/models/game_board.dart';

class MineField extends StatefulWidget {
  const MineField({super.key});

  @override
  State<MineField> createState() => _MineFieldState();
}

class _MineFieldState extends State<MineField> {
  bool? _winner;
  final _gameBoard = GameBoard(lines: 10, columns: 10, amountBombs: 5);

  Future<void> _showConfirmDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('Do you want to play again?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _reset() {
    setState(() {
      _winner = null;
      _gameBoard.reset();
    });
  }

  void _onOpen(Field field) {
    if (_winner != null) return;
    setState(() {
      try {
        field.open();
        if (_gameBoard.isGameOver) {
          _winner = true;
        }
      } on Explosion {
        _winner = false;
        _gameBoard.showBombs();
      }
    });
  }

  void _onSwitchMark(Field field) {
    if (_winner != null) return;
    setState(() {
      field.switchMark();
      if (_gameBoard.isGameOver) {
        _winner = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultGame(winner: _winner, onRestart: _reset),
      body: BoardGame(
        gameBoard: _gameBoard,
        onOpen: _onOpen,
        onSwitchMark: _onSwitchMark,
      ),
    );
  }
}
