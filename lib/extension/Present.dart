import 'package:flutter/cupertino.dart';
import 'package:we_slide/we_slide.dart';
 
mixin Present<T extends StatefulWidget> on State<T> {
  final WeSlideController _controller = WeSlideController();
  Widget? _present;

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
      panelMinSize: 0,
      panelWidth: MediaQuery.of(context).size.width,
      panel: SizedBox(
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: _present),
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


