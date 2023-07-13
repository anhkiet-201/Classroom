import 'dart:io';

import 'package:camera/camera.dart';

class CameraInstants {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  static int _cameraIndex = -1;
  CameraController? get controller => _controller;
  static CameraDescription currentCamera = _cameras[_cameraIndex];
  List<CameraDescription> get cameraList => _cameras;
  CameraLensDirection cameraLensDirection = CameraLensDirection.back;
  Future<bool> initialize(
      {CameraLensDirection? initialCameraLensDirection}) async {
    cameraLensDirection = initialCameraLensDirection ?? CameraLensDirection.back;
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == cameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _controller = CameraController(
        _cameras[_cameraIndex],
        // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      return true;
    }
    return false;
  }
}
