import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AboutClassScreen extends StatelessWidget {
  const AboutClassScreen(this.classroom, {Key? key}) : super(key: key);
  final Classroom classroom;
  final spacer = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithAppbar(
      title: 'About class',
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Iconsax.save_2),)
      ],
      child: Column(
        children: [
          spacer,
          AspectRatio(
              aspectRatio: 14/9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const CustomImage(
                    'https://images.unsplash.com/photo-1596401057633-54a8fe8ef647?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dmlldG5hbXxlbnwwfHwwfHw%3D&w=1000&q=80',
                    fit: BoxFit.cover,
                    borderRadius: 15,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.image_rounded, color: Colors.white,)),
                  )
                ],
              )
          ),
          spacer,

        ],
      ),
    );
  }
}
