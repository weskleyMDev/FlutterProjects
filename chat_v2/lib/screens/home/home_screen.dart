import 'package:chat_v2/stores/form/login/login_form.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../components/input_text.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _loginStore = GetIt.instance<LoginFormStore>();

  @override
  Widget build(BuildContext context) {
    final userName = _loginStore.currentUser?.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $userName'),
        actions: [
          IconButton(
            onPressed: () async {
              await _loginStore.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
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
