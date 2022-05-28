import 'package:flutter/material.dart';

abstract class AnimatedState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  Animation? animation;

  void initController(
      {required Duration duration,
      Duration? reverseDuration,
      String? debugLabel}) {
    controller = AnimationController(
      debugLabel: debugLabel,
      vsync: this,
      duration: duration,
      reverseDuration: reverseDuration ?? duration,
    );
  }

  initAnimation({
    required Tween tween,
    Curve curve = Curves.easeInCubic,
    double begin = 0,
    double end = 1,
  }) {
    assert(
      begin >= 0 && begin < end && end <= 1,
      "Error when creating the animation object",
    );

    animation = tween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: curve),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
