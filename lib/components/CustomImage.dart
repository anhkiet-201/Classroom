import 'package:flutter/material.dart';

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
            ),
          );
  }
}
