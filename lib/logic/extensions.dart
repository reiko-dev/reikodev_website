import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const ext = "";

extension StringExtension on String {
  String capitalizeFirst() {
    return substring(0, 1).toUpperCase() + substring(1);
  }
}

extension AnimationExtension on AnimationController {
  void loop({bool reverse = true}) {
    addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          if (reverse) {
            this.reverse();
          } else {
            reset();
            forward();
          }
          break;
        case AnimationStatus.dismissed:
          forward();
          break;
        default:
          break;
      }
    });
  }
}
