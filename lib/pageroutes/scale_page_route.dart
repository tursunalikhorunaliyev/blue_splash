import 'package:flutter/material.dart';

class ScalePageRoute extends PageRouteBuilder {
  final Widget oyna;

  ScalePageRoute(this.oyna)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => oyna,
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, boshqaanim, child) {
              animation = CurvedAnimation(
                  curve: Curves.bounceIn,
                  parent: animation,
                  reverseCurve: Curves.bounceIn);
              return ScaleTransition(
                scale: animation,
                child: oyna,
              );
            });
}
