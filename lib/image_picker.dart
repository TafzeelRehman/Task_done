import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> showImageSourceDialog(
    BuildContext context, Function(ImageSource) pickImage) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Choose Image Source',
          style: TextStyle(
            color: Color(0xFFE0847D),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              pickImage(ImageSource.gallery);
            },
            child: const Text(
              'Gallery',
              style: TextStyle(
                color: Color(0xFFE0847D),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              pickImage(ImageSource.camera);
            },
            child: const Text(
              'Camera',
              style: TextStyle(
                color: Color(0xFFE0847D),
              ),
            ),
          ),
        ],
      );
    },
  );
}
