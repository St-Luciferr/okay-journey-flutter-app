import 'package:flutter/material.dart';
import 'dart:io';

class PictureScreen extends StatelessWidget {
  final String imagePath;

  final double height, width;
  const PictureScreen(
      {super.key,
      required this.imagePath,
      required this.height,
      required this.width});

  // for (var item in rec) {}
  @override
  Widget build(BuildContext context) {
    File imgfile = File(imagePath);
    Image img = Image.file(imgfile);

    return Scaffold(
      appBar: AppBar(title: const Text('Captured Image')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: img,
      ),
    );
  }
}
