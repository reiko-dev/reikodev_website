// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:reikodev_website/app/ui/pages/background/star_field/star_field.dart';

class BackgroundPage extends StatefulWidget {
  BackgroundPage() : super(key: gkey);

  static final GlobalKey<dynamic> gkey = GlobalKey();

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage>
    with SingleTickerProviderStateMixin {
  static const double idleSpeed = .2; //.2
  static const double maxSpeed = 10;
  static const int starAnimDurationIn = 2500;

  final ValueNotifier<double> _speedValue = ValueNotifier(idleSpeed);

  late final AnimationController _starAnimController;
  late final Animation<double> _starAnimSequence;

  @override
  void initState() {
    _starAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: starAnimDurationIn),
      reverseDuration: const Duration(milliseconds: starAnimDurationIn ~/ 3),
    );
    _starAnimController
        .addListener(() => _speedValue.value = _starAnimSequence.value);

    //Create an animation sequence that moves our stars back, then forwards, then to rest at 0.
    //This will be played each time we load a detail page, to create a flying through space transition effect
    _starAnimSequence = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: idleSpeed, end: -2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -2, end: 20)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 20, end: idleSpeed)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      )
    ]).animate(_starAnimController);

    super.initState();
  }

  @override
  void dispose() {
    _starAnimController.dispose();
    super.dispose();
  }

  void onScroll(double delta) {
    if (delta == 0) {
      _speedValue.value = idleSpeed;
    } else {
      //clamp scrollDelta to min/max values
      _speedValue.value = delta.clamp(
        -maxSpeed,
        maxSpeed,
      );
    }
  }

  void animateFromStart() {
    _starAnimController.forward(from: 0);
  }

  void onItemTap() => _starAnimController.forward(from: 0);

  void reverse() => _starAnimController.reverse(from: 1);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: ValueListenableBuilder<double>(
          valueListenable: _speedValue,
          builder: (c, value, _) {
            return StarField(starSpeed: value);
          },
        ),
      ),
    );
  }
}

class BGAnimator extends InheritedWidget {
  // ignore: prefer_const_constructors_in_immutables
  BGAnimator({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final bgAnimatorKey = BackgroundPage.gkey;
  static BGAnimator? of(BuildContext context) {
    final BGAnimator? result =
        context.dependOnInheritedWidgetOfExactType<BGAnimator>();
    if (result == null) {
      debugPrint('No BGAnimatorData found.');
    }
    return result;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
