import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum NavigatorType {
  fade,
  slide,
  scale,
  normal;

  Widget builder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (this) {
      case fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case slide:
        return SlideTransition(
          position: animation.drive(Tween<Offset>(
              begin: const Offset(1, 0), end: const Offset(0, 0))),
          child: child,
        );
      case scale:
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      case normal:
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
    }
  }
}

extension NavigatorContext on BuildContext {
  Future<T?> startActivity<T>(Widget target,
      {NavigatorType type = NavigatorType.normal,
      Duration duration = const Duration(milliseconds: 300)}) {
    ScaffoldMessenger.maybeOf(this)
      ?..hideCurrentSnackBar()
      ..hideCurrentMaterialBanner();
    return Navigator.of(this).push<T>(PageRouteBuilder<T>(
        /// [opaque] set false, then the detail page can see the home page screen.
        opaque: false,
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        fullscreenDialog: true,
        pageBuilder: (context, _, __) => target,
        transitionsBuilder: type.builder));
  }

  Future<T?> finish<T>([T? result]) async {
    Navigator.of(this).maybePop();
    return result;
  }

}

