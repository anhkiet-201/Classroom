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
            child: Image.network(
              url,
              height: height,
              width: width,
              fit: fit,
              errorBuilder: (_, e, s) => Image.asset(
                'assets/images/avatar_error.png',
                height: height,
                width: width,
                fit: fit,
              ),
              loadingBuilder: (_, child, progress){
                return progress == null ? child : SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          LoadingAnimationWidget.twistingDots(
                          size: (width ?? 1) / (height ?? 1) * 20,
                          leftDotColor: primaryColor,
                          rightDotColor: secondaryColor,
                        ),
                        Text(
                          '${((progress.cumulativeBytesLoaded / progress.expectedTotalBytes!) * 100 ).roundToDouble()} %',
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

class _ImgLodingText extends StatefulWidget {
  const _ImgLodingText({Key? key}) : super(key: key);


  @override
  State<_ImgLodingText> createState() => _ImgLodingTextState();
}

class _ImgLodingTextState extends State<_ImgLodingText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'da'
    );
  }
}

