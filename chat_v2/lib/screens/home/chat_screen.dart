import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../stores/form/message/message_form.store.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final store = GetIt.instance<MessageFormStore>();
  @override
  void initState() {
    store.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.messages,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading messages!'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No messages found!'));
            } else {
              final messages = snapshot.data ?? [];
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
                    leading: message.imageUrl == null
                        ? CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: SvgPicture.asset(
                              'assets/images/svg/default-user.svg',
                              fit: BoxFit.fill,
                              height: 50.0,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(message.imageUrl!),
                          ),
                    title: Text('${message.text} - $time'),
                    subtitle: Text(
                      '${date.toUpperCase()[0]}${date.toLowerCase().substring(1)}',
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
