import 'package:flutter/material.dart';

extension HeroTag on Widget {
  Hero mainTag(String tag) => Hero(
        tag: tag,
        transitionOnUserGestures: true,
        child: this,
        flightShuttleBuilder:
            (flightContext, animation, direction, fromcontext, toContext) {
          final Hero toHero = toContext.widget as Hero;
          final Hero fromHero = fromcontext.widget as Hero;
          // Change push and pop animation.
          return Material(
            color: Colors.transparent,
            child: direction == HeroFlightDirection.push
                ? toHero.child
                : fromHero.child,
          );
        },
      );

  Hero subTag(String tag) => Hero(
        tag: tag,
        child: this
      );
}
