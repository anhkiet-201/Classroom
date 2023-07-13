import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/extension/HeroTag.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClassroomQrShare extends StatelessWidget {
  const ClassroomQrShare(this.data, {Key? key}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Scan this QR',
              style: TextStyle(color: primaryColor, fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: QrImage(
                data: 'chinchin_classroom: $data',
                eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.circle, color: primaryColor),
              ),
            ),
            Text(
              'Or use this code to join class:',
              style: TextStyle(color: primaryColor, fontSize: 20),
            ),
            Text(
              data,
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            )
          ],
        ),
      )),
    );
  }
}
