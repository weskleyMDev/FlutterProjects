import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';

import '../stores/form/input_form.store.dart';

enum Menu { emojis, camera, audio, gallery }

class InputText extends StatelessWidget {
  const InputText({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GetIt.instance<InputFormStore>();
    return Form(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: PopupMenuButton<Menu>(
              popUpAnimationStyle: const AnimationStyle(
                curve: Easing.emphasizedDecelerate,
                duration: Duration(seconds: 1),
              ),
              onSelected: (item) {
                switch (item) {
                  case Menu.gallery:
                    print('Gallery');
                    break;
                  case Menu.audio:
                    print('Audio');
                    break;
                  case Menu.camera:
                    print('Camera');
                    break;
                  case Menu.emojis:
                    print('Emojis');
                    break;
                  case null:
                    return;
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: Menu.gallery,
                    child: ListTile(
                      leading: Icon(
                        FontAwesome5.folder_open,
                        color: Colors.orange,
                      ),
                      title: Text('Gallery'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: Menu.audio,
                    child: ListTile(
                      leading: Icon(FontAwesome5.music, color: Colors.blue),
                      title: Text('Audio'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: Menu.camera,
                    child: ListTile(
                      leading: Icon(
                        FontAwesome5.camera_retro,
                        color: Colors.red,
                      ),
                      title: Text('Camera'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: Menu.emojis,
                    child: ListTile(
                      leading: Icon(FontAwesome5.smile, color: Colors.amber),
                      title: Text('Emojis'),
                    ),
                  ),
                ];
              },
            ),
          ),
          Expanded(
            flex: 10,
            child: TextFormField(
              decoration: InputDecoration(
                label: Text('Message', overflow: TextOverflow.ellipsis),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                store.isWriting = text.isNotEmpty;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Observer(
              builder: (_) => IconButton(
                onPressed: store.isWriting ? () {} : null,
                icon: Icon(Icons.send_outlined),
                color: Colors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
