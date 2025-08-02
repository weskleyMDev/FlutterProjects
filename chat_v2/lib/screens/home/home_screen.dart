import 'package:flutter/material.dart';

import '../../components/input_text.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(flex: 9, child: ChatScreen()),
            Expanded(child: InputText()),
          ],
        ),
      ),
    );
  }
}
