import 'package:camera/camera.dart';
import 'package:class_room_chin/components/painters/BarcodeDetectorPainter.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:iconsax/iconsax.dart';

import 'CameraView.dart';

class ScanQR extends StatefulWidget {
  ScanQR({super.key, this.onResult});
  final Function(List<Barcode> barcodes)? onResult;
  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  SizedBox(
        width: size.width,
        height: (size.width / 9) * 16,
        child: CameraView(
          customPaint: _customPaint,
          onImage: (image) => _processImage(image),
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          action: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.image,
                color: Colors.white,
              )),
        )
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final barcodes = await _barcodeScanner.processImage(inputImage);
    widget.onResult?.call(barcodes);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = BarcodeDetectorPainter(
        barcodes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      // String text = 'Barcodes found: ${barcodes.length}\n\n';
      // for (final barcode in barcodes) {
      //   text += 'Barcode: ${barcode.rawValue}\n\n';
      // }
      // // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
