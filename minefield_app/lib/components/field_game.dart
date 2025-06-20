import 'package:flutter/material.dart';
import 'package:minefield_app/models/field.dart';

class FieldGame extends StatelessWidget {
  const FieldGame({
    super.key,
    required this.field,
    required this.onOpen,
    required this.onSwitchMark,
  });

  final Field field;
  final Function(Field) onOpen;
  final Function(Field) onSwitchMark;

  Widget _getImage() {
    int qttMines = field.manyMinesInNeighborhood;
    if (field.isOpened && field.isMined && field.isBursted) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.isOpened && field.isMined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.isOpened) {
      return Image.asset('assets/images/aberto_$qttMines.jpeg');
    } else if (field.isMarked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onSwitchMark(field),
      child: _getImage(),
    );
  }
}
