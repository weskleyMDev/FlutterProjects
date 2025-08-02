import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../stores/form/input_form.store.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final store = GetIt.instance<InputFormStore>();
  @override
  void initState() {
    store.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        switch (store.status) {
          case FutureStatus.pending:
            return const Center(child: CircularProgressIndicator());
          case FutureStatus.rejected:
            return const Center(child: Text('Error'));
          case FutureStatus.fulfilled:
            final messages = store.messages;
            if (messages.isEmpty) {
              return const Center(child: Text('No messages'));
            }
            return ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final date = DateFormat(
                  'EEEE, dd/MM/yyyy',
                  'pt_BR',
                ).format(message.createAt);
                final time = DateFormat('HH:mm').format(message.createAt);
                return ListTile(
                  title: Text('${message.text} - $time'),
                  subtitle: Text(
                    '${date.toUpperCase()[0]}${date.toLowerCase().substring(1)}',
                  ),
                );
              },
            );
        }
      },
    );
  }
}
