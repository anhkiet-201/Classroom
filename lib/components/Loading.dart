import 'package:class_room_chin/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  LoadingAnimationWidget.twistingDots(
          size: 50,
          leftDotColor: primaryColor,
          rightDotColor: secondaryColor,
        ),
      ),
    );
  }
}
