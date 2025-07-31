import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageFormField extends StatefulWidget {
  const ImageFormField({
    super.key,
    required this.onImageSelected,
    this.imagePath,
  });

  final void Function(File) onImageSelected;
  final File? imagePath;

  @override
  State<ImageFormField> createState() => _ImageFormFieldState();
}

class _ImageFormFieldState extends State<ImageFormField> {
  File? _image;

  @override
  initState() {
    super.initState();
    if (widget.imagePath != null) {
      _image = widget.imagePath;
    }
  }

  Future<void> _takePicture() async {
    if (Platform.isAndroid) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600.0,
        maxHeight: 600.0,
      );
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });

      final appDir = await getApplicationDocumentsDirectory();
      final String fileName = path.basename(
        _image?.path ?? '${DateTime.now()}.jpg',
      );
      final File? savedImage = await _image?.copy('${appDir.path}/$fileName');
      widget.onImageSelected(savedImage!);
    } else if (Platform.isWindows) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result == null) return;
      final filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          _image = File(filePath);
        });
      }
      widget.onImageSelected(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image == null
            ? CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/images/profile.png'),
              )
            : CircleAvatar(radius: 80.0, backgroundImage: FileImage(_image!)),
        const SizedBox(height: 10.0),
        _image == null
            ? TextButton.icon(
                onPressed: _takePicture,
                icon: Icon(Icons.add_a_photo_outlined),
                label: Text('Select an Image'),
              )
            : TextButton.icon(
                onPressed: _takePicture,
                icon: Icon(FontAwesome5.exchange_alt),
                label: Text('Change Image'),
              ),
      ],
    );
  }
}
