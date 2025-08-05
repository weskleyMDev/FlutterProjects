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
        title: Text(userName == null ? 'Hello, user' : 'Hello, $userName'),
        actions: [
          IconButton(
            onPressed: () async {
              await _loginStore.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatScreen(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black87,
            ),
            padding: const EdgeInsets.all(12.0),
            child: InputText(),
          ),
        ],
      ),
    );
  }
}
