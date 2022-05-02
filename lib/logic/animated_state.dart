import 'package:flutter/material.dart';

//Extends a State<StatefulWidget>

abstract class AnimatedState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  init({required Duration duration, required Duration reverseDuration}) {
    controller = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: reverseDuration,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
