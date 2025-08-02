import 'dart:convert';
import 'dart:io';

import 'package:chat_v2/stores/form/input_form.store.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

enum Menu { emojis, camera, audio, gallery }

class PopupmenuMessage extends StatelessWidget {
  const PopupmenuMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GetIt.instance<InputFormStore>();

    Future<void> uploadImage(File imageFile) async {
      try {
        final uri = Uri.https('api.cloudinary.com', '/v1_1/dcfabcpnx/upload');
        final uploadRequest = http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = 'dcfabcpnx'
          ..files.add(
            await http.MultipartFile.fromPath('file', imageFile.path),
          );

        final response = await uploadRequest.send();
        if (response.statusCode >= 400) {
          throw Exception('Failed to upload image');
        } else {
          final responseBody = await response.stream.bytesToString();
          final jsonMap = json.decode(responseBody);
          final imageUrl = jsonMap['secure_url'];
          store.formData['imageUrl'] = imageUrl;
        }
      } catch (e) {
        rethrow;
      }
    }
    
    return PopupMenuButton<Menu>(
      popUpAnimationStyle: const AnimationStyle(
        curve: Easing.emphasizedDecelerate,
        duration: Duration(seconds: 1),
      ),
      onSelected: (item) async {
        switch (item) {
          case Menu.gallery:
            break;
          case Menu.audio:
            break;
          case Menu.camera:
            if (Platform.isAndroid) {
              final imageFile = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (imageFile == null) return;
              store.file = File(imageFile.path);
              uploadImage(store.file!);
            } else if (Platform.isWindows) {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
              if (result == null) return;
              final filePath = result.files.first.path;
              if (filePath == null) return;
              store.file = File(filePath);
              await uploadImage(store.file!);
            }
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
