import 'package:flutter/material.dart';

class SlideTransitionTop extends PageRouteBuilder {
  final Widget oyna;

  SlideTransitionTop(this.oyna)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => oyna,
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, boshqaanim, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(
                        begin: const Offset(0.0, -1.0),
                        end: const Offset(0.0, 0.0))
                    .animate(animation),
                child: oyna,
              );
            });
}