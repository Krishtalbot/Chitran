import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraState();
}

class _CameraState extends State<CameraWidget> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    startCamera();
  }

  Future<void> startCamera() async {
    cameras = await availableCameras();

    if (cameras.isEmpty) {
      print("No cameras available on this device.");
      return;
    }

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.low,
      enableAudio: false,
    );
    try {
      await cameraController!.initialize();

      setState(() {});
    } catch (e) {
      setState(() {});
      print(e);
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController != null && cameraController!.value.isInitialized) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color(0xFFaede71)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CameraPreview(cameraController!),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
