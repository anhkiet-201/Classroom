import 'package:cached_network_image/cached_network_image.dart';
import 'package:class_room_chin/utils/Extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/Colors.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(this.url,
      {Key? key,
      this.width,
      this.height,
      this.borderRadius = 0,
      this.fit = BoxFit.cover})
      : super(key: key);
  final String url;
  final double? height;
  final double? width;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child:Image.asset(
              'assets/images/avatar_error.png',
              height: height,
              width: width,
              fit: fit,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: CachedNetworkImage(
              imageUrl: url,
              height: height,
              width: width,
              fit: fit,
              errorWidget: (_, e, s) => Image.asset(
                'assets/images/avatar_error.png',
                height: height,
                width: width,
                fit: fit,
              ),
              progressIndicatorBuilder: (_, url, progress){
                return SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.twistingDots(
                          size: (width ?? 1) / (height ?? 1) * 20,
                          leftDotColor: context.getDynamicColor().primary,
                          rightDotColor: context.getDynamicColor().secondary,
                        ),
                        Text(
                          '${((progress.progress ?? 1) * 100).round()} %',
                          style: TextStyle(
                              fontSize: (width ?? 1) / (height ?? 1) * 10
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}

