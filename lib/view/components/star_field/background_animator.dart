import 'package:flutter/material.dart';
import 'package:reikodev_website/view/components/star_field/star_field.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({Key? key}) : super(key: key);

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  int starCount = 400;
  static const double idleSpeed = .2;
  static const double maxSpeed = 10;
  static const int starAnimDurationIn = 4500;

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
    _starAnimController.addListener(() {
      _speedValue.value = _starAnimSequence.value;
    });

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
        tween: Tween<double>(begin: 20, end: 0)
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

  //When the list is scrolled, use it's velocity to control the speed of the starfield
  void handleListScroll(double delta) {
    late double newVal;

    if (delta == 0) {
      newVal = idleSpeed;
    } else {
      //clamp scrollDelta to min/max values
      newVal = delta.clamp(
        -maxSpeed,
        maxSpeed,
      );
    }
    if (_speedValue.value == newVal) return;

    setState(() {
      _speedValue.value = newVal;
    });
  }

  //When an item in the list is tapped, push a Detail view onto the navigator. Pass along the data as as route argument.
  // void _handleListItemTap(ConstellationData data, bool redMode) {
  // ignore: unused_element
  void _handleListItemTap() {
    //Add details page to Navigator
    // _navigationStackKey.currentState.pushNamed(
    //   ConstellationDetailView.route,
    //   arguments: _DetailViewRouteArguments(data, redMode),
    // );
    //Start star transition
    _starAnimController.forward(from: 0);
  }

  // ignore: unused_element
  void _reverseStarAnim() {
    if (_starAnimController.isAnimating) {
      _starAnimController.reverse();
    } else {
      _speedValue.value = idleSpeed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: ValueListenableBuilder<double>(
          valueListenable: _speedValue,
          builder: (c, value, _) {
            return StarField(starCount: starCount, starSpeed: value);
          },
        ),
      ),
    );
  }
}
