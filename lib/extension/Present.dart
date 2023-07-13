import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_slide/we_slide.dart';
 
mixin Present<T extends StatefulWidget> on State<T> {
  final WeSlideController _controller = WeSlideController();
  Widget? _present;
  double _minHeight = 0;

  void setPresentMinHeight(double minHeight) {
    _minHeight = minHeight;
  }

  void showPresent({required Widget content}) {
    setState(() {
      _present = content;
    });
    if (_present != null) {
      _controller.show();
    }
  }

  void hidePresent() {
    if (_controller.isOpened) {
      _controller.hide();
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      if (_controller.isOpened) {
        _controller.hide();
      } else {
        return true;
      }
      return false;
    },
    child: WeSlide(
      controller: _controller,
      panelMaxSize: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).padding.top + 100),
      transformScale: true,
      transformScaleEnd: 0.9,
      panelMinSize: _minHeight,
      panelWidth: MediaQuery.of(context).size.width,
      panel: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Material(
          child: SizedBox(
            child: _present,
          ),
        ),
      ),
      body: SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: body(context),
        ),
      ),
    ),
  );

  Widget body(BuildContext context);
}



