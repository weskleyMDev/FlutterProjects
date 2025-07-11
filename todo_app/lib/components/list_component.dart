import 'package:flutter/material.dart';

class ListComponent extends StatelessWidget {
  const ListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          color: Theme.of(context).cardColor,
          child: ListTile(title: Text('Item 1')),
        ),
      ],
    );
  }
}
