import 'package:flutter/material.dart';

import '../factorys/firebase_services_factory.dart';
import '../models/chat_message.dart';
import '../screens/loading_screen.dart';
import 'message_box.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final data = FirebaseServicesFactory.instance.createDataService();
    final auth = FirebaseServicesFactory.instance.createAuthService();
    final currentUser = auth.currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: data.messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma mensagem encontrada.'));
        } else {
          final messages = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => MessageBox(
              key: ValueKey(messages[index].id),
              message: messages[index],
              isCurrentUser: currentUser?.id == messages[index].userId,
            ),
          );
        }
      },
    );
  }
}
