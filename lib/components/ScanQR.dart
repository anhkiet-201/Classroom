import 'dart:io';
import 'package:camera/camera.dart';
import 'package:class_room_chin/components/painters/BarcodeDetectorPainter.dart';
import 'package:class_room_chin/constants/CameraInstants.dart';
import 'package:class_room_chin/constants/enum/ScanQrType.dart';
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'CameraView.dart';

class ScanQR extends StatefulWidget {
  ScanQR(
      {super.key,
      this.onResult,
      required this.cameraInstants,
      this.scanType = ScanQrType.live,
      required this.onScanTypeChange});

  final Function(List<Barcode> barcodes)? onResult;
  final Function(ScanQrType type) onScanTypeChange;
  ScanQrType scanType;
  final CameraInstants cameraInstants;

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  File? _image;
  String? _path;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: (size.width / 9) * 16,
        child: widget.scanType == ScanQrType.image
            ? (_image != null
                ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: GestureDetector(
                    onTap: () {
                      widget.onScanTypeChange(ScanQrType.live);
                    },
                    child: Text(
                      'Image is empty!\n'
                      'Click to Rescan.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: context.getDynamicColor.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )))
            : CameraView(
                cameraInstants: widget.cameraInstants,
                customPaint: _customPaint,
                onImage: (image) => _processImage(image),
                action: IconButton(
                    onPressed: _getImage,
                    icon: const Icon(
                      Icons.image,
                      color: Colors.white,
                    )),
              ));
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
        CameraLensDirection.back,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      // // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future _getImage() async {
    _image = null;
    _path = null;
    widget.onScanTypeChange(ScanQrType.image);
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _processPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _processPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
    _canProcess = true;
    _isBusy = false;
    _processImage(inputImage);
  }
}
