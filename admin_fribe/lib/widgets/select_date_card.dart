import 'package:flutter/material.dart';

class SelectDateCard extends StatelessWidget {
  const SelectDateCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tooltip,
    required this.selectDate,
    required this.iconColor,
  });

  final String title;
  final String? subtitle;
  final String tooltip;
  final VoidCallback selectDate;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle ?? 'Select date'),
        trailing: IconButton(
          icon: Icon(Icons.calendar_month, color: iconColor),
          onPressed: selectDate,
          tooltip: tooltip,
        ),
      ),
    );
  }
}
