import 'package:class_room_chin/components/SnackBar.dart';
import 'package:class_room_chin/constants/enum/PermissionManagerType.dart';
import 'package:class_room_chin/extension/NavigatorContext.dart';
import 'package:class_room_chin/screen/scan_qr/ScanQRScreen.dart';
import 'package:class_room_chin/utils/PermissionManager.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/CustomScaffoldWithAppBar.dart';

class JoinClassroom extends StatefulWidget {
  const JoinClassroom({super.key});

  @override
  State<JoinClassroom> createState() => _JoinClassroomState();
}

class _JoinClassroomState extends State<JoinClassroom>
    with WidgetsBindingObserver {

  bool _scanQRClick = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithAppbar(
      title: 'Join class',
      actions: [
        IconButton(
            onPressed: _qrScanButtonHandler,
            icon: const Icon(Icons.qr_code_2_rounded))
      ],
      child: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  _qrScanButtonHandler() {
    _scanQRClick = true;
    PermissionManager.instants.requestPermissionIfNeed(
        type: PermissionManagerType.camera, onCompete: _qrScanCompleteHandler);
  }

  _qrScanCompleteHandler(bool granted) {
    if (granted) {
      context.startActivity(const ScanQRScreen(), duration: const Duration(milliseconds: 300));
      _scanQRClick = false;
    }
  }

  /// inactive 1
  /// paused 2
  /// resumed 0
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0 && _scanQRClick) {
      _handleOnResume();
    }
  }

  _handleOnResume() async {
    PermissionManager.instants
        .checkPermissionStatus(type: PermissionManagerType.camera)
        .then((value) {
      if (value.isDenied) {
        ShowSnackbar(context, content: 'Permission is denied', type: SnackBarType.error);
      } else {
        context.startActivity(const ScanQRScreen(), duration: const Duration(milliseconds: 300));
      }
      _scanQRClick = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
}
