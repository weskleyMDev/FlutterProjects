import 'package:flutter_test/flutter_test.dart';
import 'package:minefield_app/models/field.dart';

void main() {
  group('Field Test', () {
    test('open field WITH burst', () {
      Field c = Field(line: 0, column: 0);
      c.mine();
      expect(c.open, throwsException);
    });
    test('open field WITHOUT burst', () {
      Field c = Field(line: 0, column: 0);
      c.open();
      expect(c.isOpened, isTrue);
    });
    test('add NO neightbor', () {
      Field c = Field(line: 0, column: 0);
      c.addNeighbor(Field(line: 1, column: 3));
      expect(c.neighbors.isEmpty, isTrue);
    });
    test('add SOME neightbors', () {
      Field c = Field(line: 3, column: 3);
      Field n1 = Field(line: 3, column: 4);
      Field n2 = Field(line: 2, column: 2);
      Field n3 = Field(line: 4, column: 4);

      c.addNeighbor(n1);
      c.addNeighbor(n2);
      c.addNeighbor(n3);

      expect(c.neighbors.length, 3);
    });
    test('mines AT neightbors', () {
      Field c = Field(line: 3, column: 3);
      Field n1 = Field(line: 3, column: 4);
      n1.mine();
      Field n2 = Field(line: 2, column: 2);
      Field n3 = Field(line: 4, column: 4);
      n3.mine();

      c.addNeighbor(n1);
      c.addNeighbor(n2);
      c.addNeighbor(n3);

      expect(c.manyMinesInNeighborhood, 2);
    });
  });
}
