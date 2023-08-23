import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'coordinates_translator.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(
    this.barcodes,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<Barcode> barcodes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint textPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white;

    for (final Barcode barcode in barcodes) {

      final left = translateX(
        barcode.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        barcode.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final progress = (((right - left) / 3) / 100);
      final top = translateY(
        barcode.boundingBox.top - (progress * 70),
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        barcode.boundingBox.top - (progress * 10),
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.center,
            maxLines: 1,
            fontSize: progress * 20,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          )
      );
      builder.addText('${barcode.displayValue}');
      builder.pop();

      //
      // // Draw a bounding rectangle around the barcode

      canvas.drawRRect(
        RRect.fromLTRBR(left, top, right, bottom, const Radius.circular(20)),
        textPaint
      );

      final List<Offset> cornerPoints = <Offset>[];
      for (final point in barcode.cornerPoints) {
        final double x = translateX(
          point.x.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );
        final double y = translateY(
          point.y.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );

        cornerPoints.add(Offset(x, y));
      }

      // Add the first point to close the polygon
      cornerPoints.add(cornerPoints.first);
      canvas.drawPoints(PointMode.polygon, cornerPoints, borderPaint);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: ((left - right) + 40).abs(),
          )),
        Offset(
            Platform.isAndroid &&
                    cameraLensDirection == CameraLensDirection.front
                ? right
                : left + 20,
            top + (progress * 5)),
      );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
