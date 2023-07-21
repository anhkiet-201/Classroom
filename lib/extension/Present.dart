import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:flutter/material.dart';
import 'package:we_slide/we_slide.dart';
 
mixin Present<T extends StatefulWidget> on State<T> {
  final WeSlideController _controller = WeSlideController();
  Widget? _present;
  double _minHeight = 0;

  @mustCallSuper
  @override
  void initState() {
    if(!_controller.hasListeners) {
      _controller.addListener(() {
        if(_controller.isOpened) {
          onShowPresent();
        } else {
          onHidePresent();
        }
      });
    }
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    if(_controller.hasListeners) {
      _controller.removeListener(() { });
    }
    super.dispose();
  }

  void setPresentMinHeight(double minHeight) {
    _minHeight = minHeight;
  }

  void showPresent({required Widget content}) {
    FocusScope.of(context).unfocus();
    setState(() {
      _present = content;
    });
    if (_present != null) {
      _controller.show();
    }
  }

  void onHidePresent() {
  }

  void onShowPresent() {
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
      blur: true,
      blurSigma: 1.0,
      blurColor: context.getDynamicColor.primary,
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



