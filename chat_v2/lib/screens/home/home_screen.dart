import 'package:flutter/material.dart';

import '../../components/input_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(child: Center(child: Text('BODY'))),
            ),
            Expanded(child: Container(child: InputText())),
          ],
        ),
      ),
    );
  }
}
