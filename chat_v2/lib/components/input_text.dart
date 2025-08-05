import 'package:chat_v2/components/popupmenu_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/form/message/message_form.store.dart';

class InputText extends StatefulWidget {
  const InputText({super.key});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final store = GetIt.instance<MessageFormStore>();
  final _chatFormKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _chatFormKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _chatFormKey.currentState?.save();
    await store.sendMessage();
    _textController.clear();
    _chatFormKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _chatFormKey,
      child: Row(
        children: [
          PopupmenuMessage(),
          Expanded(
            child: TextFormField(
              key: const ValueKey('message'),
              controller: _textController,
              decoration: InputDecoration(
                label: Text('Message', overflow: TextOverflow.ellipsis),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                store.isWriting = text.isNotEmpty;
              },
              onSaved: (text) => store.formData['text'] = text?.trim() ?? '',
              validator: (text) {
                final message = text?.trim() ?? '';
                if (message.isEmpty) {
                  return 'Message is required';
                }
                return null;
              },
            ),
          ),
          Observer(
            builder: (_) => IconButton(
              onPressed: store.isWriting
                  ? () async => await _submitForm()
                  : null,
              icon: Icon(Icons.send_outlined),
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
