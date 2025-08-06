import 'package:flutter/material.dart';

Widget buildBodyBack({
  required Color colorX,
  required Color colorY,
  required Alignment x,
  required Alignment y,
}) => Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [colorX, colorY], begin: x, end: y),
  ),
);
