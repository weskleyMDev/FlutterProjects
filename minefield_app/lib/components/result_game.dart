import 'package:flutter/material.dart';

class ResultGame extends StatelessWidget implements PreferredSizeWidget {
  const ResultGame({super.key, required this.winner, required this.onRestart});

  final bool? winner;
  final Function onRestart;

  Color _getColor() {
    if (winner == null) {
      return Colors.amber;
    } else if (winner == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  IconData _getIcon() {
    if (winner == null) {
      return Icons.sentiment_neutral_rounded;
    } else if (winner == true) {
      return Icons.sentiment_very_satisfied_sharp;
    } else {
      return Icons.sentiment_very_dissatisfied_sharp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blueGrey,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: _getColor(),
            child: IconButton(
              onPressed: () => onRestart(),
              icon: Icon(_getIcon(), size: 40.0, color: Colors.black),
              iconSize: double.infinity,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0);
}
