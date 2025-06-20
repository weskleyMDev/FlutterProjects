import 'package:flutter_test/flutter_test.dart';
import 'package:minefield_app/models/game_board.dart';

void main() {
  test('Winning game', () {
    GameBoard gameBoard = GameBoard(lines: 2, columns: 2, amountBombs: 0);

    gameBoard.fields[0].mine();
    gameBoard.fields[3].mine();

    gameBoard.fields[0].switchMark();
    gameBoard.fields[1].open();
    gameBoard.fields[2].open();
    gameBoard.fields[3].switchMark();

    expect(gameBoard.isGameOver, isTrue);
  });
}
