import 'package:class_room_chin/constants/enum/PermissionManagerType.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final instants = PermissionManager();

  Future<PermissionStatus> checkPermissionStatus({required PermissionManagerType type}) {
    switch(type) {
      case PermissionManagerType.camera:
        return Permission.camera.status;
      case PermissionManagerType.micro:
        return Permission.microphone.status;
      case PermissionManagerType.notification:
        return Permission.notification.status;
      case PermissionManagerType.storage:
        return Permission.storage.status;
    }
  }

  Future<PermissionStatus> requestPermission({required PermissionManagerType type}) async {
    final PermissionStatus result;
    switch(type) {
      case PermissionManagerType.camera:
        result = await Permission.camera.request();
      case PermissionManagerType.micro:
        result = await Permission.microphone.request();
      case PermissionManagerType.notification:
        result = await Permission.notification.request();
      case PermissionManagerType.storage:
        result = await Permission.storage.request();
    }
    return result;
  }

  requestPermissionIfNeed({required PermissionManagerType type, required Function(bool) onCompete}) async {
    final status = await checkPermissionStatus(type: type);
    switch(status) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final result = await requestPermission(type: type);
        onCompete(result.isGranted);
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        onCompete(true);
      case PermissionStatus.permanentlyDenied:
        await openAppSettings();
        final result = await checkPermissionStatus(type: type).isGranted;
        onCompete(result);
    }
  }

}