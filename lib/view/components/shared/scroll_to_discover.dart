import 'package:flutter/material.dart';
import 'package:reikodev_website/internationalization.dart';
import 'package:reikodev_website/logic/animated_state.dart';
import 'package:reikodev_website/logic/extensions.dart';
import 'package:reikodev_website/logic/scroll_data_controller.dart';
import 'package:reikodev_website/view/components/shared/animated_arrow.dart';
import 'package:reikodev_website/view/components/shared/hover_bottom_animation.dart';

class ScrollToDiscoverWidget extends StatefulWidget {
  const ScrollToDiscoverWidget({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _ScrollToDiscoverWidgetState();
}

class _ScrollToDiscoverWidgetState extends AnimatedState {
  late final Animation<double> _opacityAnimation;

  late final Animation<double> _shimmerAnimation;

  MouseCursor _currentCursor = SystemMouseCursors.basic;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .5, curve: Curves.easeInCubic),
      ),
    );

    _shimmerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(.5, 1),
      ),
    );

    controller.forward();
    controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          controller.value = .5;
          controller.forward();
          break;

        default:
          break;
      }
    });
    ScrollDataController.i.scrollController.value.addListener(updateWidget);
  }

  void updateWidget() {
    if (!mounted) return;

    if (ScrollDataController.i.scrollController.value.position.pixels >
        screenHeight) {
      controller.animateBack(0.0);
    } else {
      controller.forward();
    }
  }

  void onEnter() {
    if (_currentCursor != SystemMouseCursors.click) {
      setState(() {
        _currentCursor = SystemMouseCursors.click;
      });
    }
  }

  void onExit() {
    if (_currentCursor != SystemMouseCursors.basic) {
      setState(() {
        _currentCursor = SystemMouseCursors.basic;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height * .05;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Visibility(
          visible: _opacityAnimation.value > 0,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: child!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 26),
        child: SizedBox(
          width: size.width > 190 ? 190 : size.width,
          height: size.height > 60 ? 60 : size.width,
          child: GestureDetector(
            onTap: () {
              ScrollDataController.i.scrollController.value.animateTo(
                size.height,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInSine,
              );
            },
            child: MouseRegion(
              onEnter: (_) => onEnter(),
              onExit: (_) => onExit(),
              cursor: _currentCursor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _shimmerAnimation,
                    builder: (_, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey.shade400,
                            Colors.white,
                          ],
                          begin: Alignment(-1 + _shimmerAnimation.value * 4, 0),
                          end: Alignment(1 + _shimmerAnimation.value * 4, 0),
                          tileMode: TileMode.mirror,
                        ).createShader(bounds),
                        child: child!,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: HoverBottomAnimation(
                        text: scrollToDiscover.capitalizeFirst(),
                      ),
                    ),
                  ),
                  const AnimatedArrow()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
