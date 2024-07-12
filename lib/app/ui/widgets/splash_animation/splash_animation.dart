import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/ui/widgets/splash_animation/transition_render_widget.dart';

enum SecondAnimationType { leftRight, rightLeft, topBottom }

class SplashAnimation extends StatefulWidget {
  const SplashAnimation(
      {super.key, this.duration = const Duration(milliseconds: 2500)});

  final Duration duration;

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> colorAnim1;
  late final Animation<double> colorAnim2;
  late final Animation<double> opacityAnim;
  late final Animation<double> scaleAnim;
  late final Animation<double> translateAnim;

  late AlignmentGeometry firstAnimationAngle;
  late AlignmentGeometry secondAnimationAngle;
  static final angles = [
    [Alignment.topLeft, Alignment.bottomRight],
    [Alignment.topCenter, Alignment.bottomCenter],
    [Alignment.topRight, Alignment.bottomLeft],
    [Alignment.centerLeft, Alignment.centerRight],
  ];

  late SecondAnimationType secondAnimationType;

  static final rand = Random();

  bool isFirstBuild = true;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    colorAnim1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.2),
      ),
    );
    colorAnim2 = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, .5, curve: Curves.decelerate),
      ),
    );
    opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, .5, curve: Curves.easeInCubic),
      ),
    );
    scaleAnim = Tween<double>(begin: .8, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.26, .5, curve: Curves.elasticOut),
      ),
    );
    translateAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(.5, 1, curve: Curves.ease),
      ),
    );
    sortAnimationData();
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  sortAnimationData() {
    final newAngle = angles[rand.nextInt(angles.length)];
    firstAnimationAngle = newAngle.first;
    secondAnimationAngle = newAngle.last;
    secondAnimationType = SecondAnimationType
        .values[rand.nextInt(SecondAnimationType.values.length)];
  }

  Offset secondAnimationOffset(double translateAnimValue, Size size) {
    switch (secondAnimationType) {
      case SecondAnimationType.rightLeft:
        return Offset(-translateAnimValue * size.width, 0);

      case SecondAnimationType.leftRight:
        return Offset(translateAnimValue * size.width, 0);

      case SecondAnimationType.topBottom:
        return Offset(0, translateAnimValue * size.height);
    }
  }

  @override
  void didChangeDependencies() {
    if (isFirstBuild) {
      controller.value = 0;
      controller.forward();
      isFirstBuild = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IgnorePointer(
      child: SizedBox.fromSize(
        size: size,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: secondAnimationOffset(translateAnim.value, size),
              child: TransitionRenderWidget(
                status: controller.status,
                animValue: colorAnim1.value + colorAnim2.value,
                backgroundColor: Theme.of(context).colorScheme.surface,
                color: Colors.white,
                beginAngle: firstAnimationAngle,
                endAngle: secondAnimationAngle,
                child: Opacity(
                  opacity: opacityAnim.value,
                  child: Transform.scale(
                    scale: scaleAnim.value,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: const Center(
            child: Text(
              splashScreenText,
              style: TextStyle(
                color: Color(0xFFdcd5c7),
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
