import 'package:flutter/material.dart';

import '../utils/Utils.dart';
import 'CustomImage.dart';
import 'PhotoView.dart';

class ImagesSlider extends StatefulWidget {
  const ImagesSlider(this.images, {Key? key}) : super(key: key);
  final List<String> images;

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = (index + 1);
              });
            },
            itemBuilder: (_, index) {
              return GestureDetector(
                child: CustomImage(
                  widget.images[index],
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  navigatorPush(context, PhotoView(widget.images[index]));
                },
              );
            },
            itemCount: widget.images.length,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                '$_currentIndex/${widget.images.length}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}