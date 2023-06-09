import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:flutter/material.dart';

class ClassoomMemberScreen extends StatelessWidget {
  const ClassoomMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithAppbar(
      title: 'Class memmber',
      child: Column(
        children: [
          Text('{user owner}'),
          Divider(color: primaryColor, thickness: 2,),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                CustomImage(
                  'd'
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
