import 'package:class_room_chin/components/SnackBar.dart';
import 'package:class_room_chin/constants/CameraInstants.dart';
import 'package:class_room_chin/constants/enum/ScanQrType.dart';
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:class_room_chin/extension/NavigatorContext.dart';
import 'package:class_room_chin/extension/Present.dart';
import 'package:class_room_chin/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/ScanQR.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen>
    with Present<ScanQRScreen> {
  List<Barcode> barcodes = [];
  final CameraInstants _cameraInstants = CameraInstants();
  bool _isScaned = false;
  ScanQrType _scanQrType = ScanQrType.live;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.black54),
            child: IconButton(
              onPressed: () => context.finish(),
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: ScanQR(
                scanType: _scanQrType,
                cameraInstants: _cameraInstants,
                onResult: (result) {
                  barcodes.clear();
                  barcodes = result;
                  if (mounted) {
                    setState(() {});
                  }
                },
                onScanTypeChange: (type) {
                  setState(() {
                    _scanQrType = type;
                  });
                },
              ),
            ),
            Expanded(
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _scanHandle,
                    icon: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: context.getDynamicColor.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: context.getDynamicColor.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Icon(
                            _isScaned ? Icons.refresh : Icons.search_rounded,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    _isScaned ||
                            (_scanQrType == ScanQrType.image &&
                                barcodes.isEmpty)
                        ? 'Rescan'
                        : 'Scan',
                    style: TextStyle(
                        color: context.getDynamicColor.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )),
            )
          ],
        ));
  }

  void _scanHandle() {
    if (barcodes.isEmpty) {
      if (_scanQrType == ScanQrType.image) {
        _scanQrType = ScanQrType.live;
        setState(() {});
        return;
      }
      ShowSnackbar(context,
          content: 'Don\'t find any Qr code!',
          type: SnackBarType.notification,
          closeButton: true);
      return;
    }
    if (_isScaned) {
      _isScaned = false;
      if (_scanQrType == ScanQrType.image) {
        _scanQrType = ScanQrType.live;
        setState(() {});
      } else {
        _cameraInstants.controller?.resumePreview();
      }
    } else {
      _isScaned = true;
      if (_scanQrType == ScanQrType.live) {
        _cameraInstants.controller?.pausePreview();
      }
      showPresent(content: _presentContent());
    }
  }

  Widget _presentContent() => Container(
        color: context.getDynamicColor.background,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: barcodes.length,
          itemBuilder: (_, index) {
            String classId = '';
            String code = barcodes[index].displayValue ?? '';
            if (code.startsWith('chinchin_classroom: ')) {
              classId = code.replaceFirst('chinchin_classroom: ', '').trim();
            }
            return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: context.getDynamicColor.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          classId.isEmpty ? code : 'Class ID: $classId',
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: context.getDynamicColor.primary),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            if (classId.isEmpty) {
                              copyToClipboard(code);
                            } else {
                              context.finish().then((value) {
                                context.finish(classId);
                              });
                            }
                          },
                          icon: classId.isEmpty
                              ? Icon(
                                  Iconsax.copy,
                                  color: context.getDynamicColor.primary,
                                )
                              : Text(
                                  'Join',
                                  style: TextStyle(
                                      color: context.getDynamicColor.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))
                    ],
                  ),
                ));
          },
        ),
      );
}
