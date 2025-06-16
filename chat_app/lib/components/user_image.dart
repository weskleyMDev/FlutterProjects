import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.onImagePick});

  final void Function(File) onImagePick;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _userImage;

  Future<void> _selectImage() async {
    if (Platform.isWindows) {
      final image = await FilePicker.platform.pickFiles(type: FileType.image);
      if (image != null) {
        setState(() {
          _userImage = File(image.files.single.path!);
        });
        widget.onImagePick(_userImage!);
      }
    } else {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150.0,
      );

      if (image != null) {
        setState(() {
          _userImage = File(image.path);
        });
        widget.onImagePick(_userImage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: _selectImage,
        child: CircleAvatar(
          radius: 60.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage: (_userImage != null) ? FileImage(_userImage!) : null,
          child: (_userImage == null)
              ? Text(
                  'Selecione uma imagem!',
                  textAlign: TextAlign.center,
                  style: TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
