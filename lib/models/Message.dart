import 'package:class_room_chin/constants/FirebaseConstants.dart';

class Message {
  final String uid;
  late final String uidImg;
  late final int time;
  final String content;
  final MessageType messageType;

  Message(
      {required this.time,
      this.messageType = MessageType.TEXT,
        required this.uidImg,
      required this.content,
      required this.uid});

  Message.create(
      {required this.uid,
      required this.content,
      this.messageType = MessageType.TEXT}) {
    time = DateTime.now().millisecondsSinceEpoch;
    uidImg = AUTH.currentUser?.photoURL ?? '';
  }

}

enum MessageType { TEXT, IMAGE }
