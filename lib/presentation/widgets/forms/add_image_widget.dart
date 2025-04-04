import 'dart:io';
import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageWidget extends StatefulWidget {
  final String hintText;
  final String documentsFolder;
  final Function(String)? onImageUploaded;

  const AddImageWidget({
    super.key,
    required this.hintText,
    required this.documentsFolder,
    this.onImageUploaded,
  });

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  final imagePicker = ImagePicker();
  String imageURL = '';

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      String url = await saveImageInLocalStorage(
        image,
        widget.documentsFolder,
      );
      setState(() => imageURL = url);
      widget.onImageUploaded?.call(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(widget.hintText)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () =>
                  _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_enhance, size: 80),
            ),
            IconButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.image, size: 80),
            ),
          ],
        ),
        if (imageURL.isNotEmpty)
          SizedBox(
            height: 200,
            child: Image.file(File(imageURL), fit: BoxFit.contain),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
