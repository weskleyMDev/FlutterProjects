import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

enum Menu { emojis, camera, audio, gallery }

class PopupmenuMessage extends StatelessWidget {
  const PopupmenuMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      popUpAnimationStyle: const AnimationStyle(
        curve: Easing.emphasizedDecelerate,
        duration: Duration(seconds: 1),
      ),
      onSelected: (item) {
        switch (item) {
          case Menu.gallery:
            break;
          case Menu.audio:
            break;
          case Menu.camera:
            break;
          case Menu.emojis:
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: Menu.gallery,
            child: ListTile(
              leading: Icon(FontAwesome5.folder_open, color: Colors.orange),
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
              leading: Icon(FontAwesome5.camera_retro, color: Colors.red),
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
    );
  }
}
