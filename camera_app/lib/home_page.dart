import 'display_picture.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.camera});
  final String title;
  final CameraDescription camera;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //to show loading screen while inference is ran
              setState(() {
                _loading = true;
              });
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;
                // Attempt to take a picture and get the file `image`
                // where it was saved.
                XFile image = await _controller.takePicture();
                setState(() {
                  _loading = false;
                });
                if (!mounted) return;
                // If the picture was taken, display it on a new screen.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PictureScreen(
                      imagePath: image.path,
                      height: 514,
                      width: 392,
                    ),
                  ),
                );
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color.fromARGB(255, 13, 174, 174),
                border: Border.all(
                  width: 4,
                  color: const Color.fromARGB(255, 50, 196, 210),
                ),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 30,
              ),
            )
            // child: const Icon(Icons.camera_alt),
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
}
