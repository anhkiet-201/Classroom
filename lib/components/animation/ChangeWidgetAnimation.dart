import 'package:flutter/material.dart';

class ChangeWidgetAnimation extends StatelessWidget {
   const ChangeWidgetAnimation({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.inCurve = Curves.linear,
    this.outCurve = Curves.linear,
    required this.child
  }) : super(key: key);
  final Curve inCurve;
  final Curve outCurve;
  final Duration duration;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: inCurve,
      switchOutCurve: outCurve,
      duration: duration,
      transitionBuilder: (child,animation)=> FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
  }
}
