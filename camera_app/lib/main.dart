import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> _cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  final camera = _cameras.first;
  runApp(MyApp(camera: camera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({super.key, required this.camera});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: 'Camera Preview',
        camera: camera,
      ),
    );
  }
}
