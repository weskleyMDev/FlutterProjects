import 'package:chat_v2/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../stores/form/login/login_form.store.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final loginStore = GetIt.instance<LoginFormStore>();
    final date = DateFormat(
      'EEEE, dd/MM/yyyy - HH:mm',
      'pt_BR',
    ).format(message.createAt);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (message.userId != loginStore.currentUser?.id)
            message.userImageUrl == null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: SvgPicture.asset(
                        'assets/images/svg/default-user.svg',
                        fit: BoxFit.fill,
                        height: 50.0,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(message.userImageUrl!),
                    ),
                  ),
          Expanded(
            child: Column(
              crossAxisAlignment: (message.userId != loginStore.currentUser?.id)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                message.imageUrl == null
                    ? Text(
                        message.text!,
                        style: const TextStyle(fontSize: 16.0),
                      )
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.network(message.imageUrl!),
                      ),
                Text(
                  '${date.toUpperCase()[0]}${date.toLowerCase().substring(1)}',
                  style: const TextStyle(fontSize: 10.0),
                ),
              ],
            ),
          ),
          if (message.userId == loginStore.currentUser?.id)
            message.userImageUrl == null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: SvgPicture.asset(
                        'assets/images/svg/default-user.svg',
                        fit: BoxFit.fill,
                        height: 50.0,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(message.userImageUrl!),
                    ),
                  ),
        ],
      ),
    );
  }
}
