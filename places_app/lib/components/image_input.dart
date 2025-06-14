import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onImagePick});

  final void Function(File) onImagePick;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    if (Platform.isAndroid) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600.0,
      );
      if (image == null) return;
      setState(() {
        _storedImage = File(image.path);
      });

      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName = path.basename(
        _storedImage?.path ?? '${DateTime.now()}.jpg',
      );
      final File? savedName = await _storedImage?.copy(
        '${appDir.path}/$fileName',
      );
      widget.onImagePick(savedName!);
    } else if (Platform.isWindows) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result == null) return;

      final filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          _storedImage = File(filePath);
        });

        widget.onImagePick(_storedImage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text(
                    'Nenhuma Imagem Selecionada',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        _storedImage == null
            ? Positioned(
                bottom: 5.0,
                child: TextButton.icon(
                  onPressed: _takePicture,
                  icon: Icon(Icons.add_a_photo_sharp),
                  label: Text('Tirar Foto'),
                ),
              )
            : IconButton(
                onPressed: _takePicture,
                icon: Icon(
                  Icons.refresh_sharp,
                  size: 42.0,
                  color: Colors.black54,
                ),
              ),
      ],
    );
  }
}
