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
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    await store.sendMessage();
    _textController.clear();
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: PopupmenuMessage(),
            ),
          ),
          Expanded(
            flex: 10,
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
          Expanded(
            flex: 1,
            child: Observer(
              builder: (_) => Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: store.isWriting
                      ? () async => await _submitForm()
                      : null,
                  icon: Icon(Icons.send_outlined),
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
