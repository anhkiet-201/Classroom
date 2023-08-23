import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:class_room_chin/extension/Optional.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.width - 100,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        context.getDynamicColor.primary, BlendMode.modulate),
                    child: Lottie.asset('assets/lottie/empty-animation.json'),
                  ),
                ),
              ),
              if (text.guard)
                Text(
                  '$text',
                  style: TextStyle(
                      color: context.getDynamicColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                )
         ],
       )
      ),
    );
  }
}
