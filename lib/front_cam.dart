import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
class FrontCamera extends StatefulWidget {
  @override
  _FrontCameraState createState() => _FrontCameraState();
}
class _FrontCameraState extends State<FrontCamera> {
  CameraController _controller;
  Future<void> _initCamFuture;
  @override
  void initState() {
    super.initState();
    _initApp();
  }
  _initApp() async {
    final cameras = await availableCameras();
    //slect another camera here
    final frontCam = cameras[1];
    _controller = CameraController(
      frontCam,
      ResolutionPreset.medium,
    );
    _initCamFuture = _controller.initialize();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Front Camera ")),
      body: FutureBuilder<void>(
        future: _initCamFuture,
        builder: (context, snapshot) {

          return CameraPreview(_controller);

        },
      ),
    );
  }
}
