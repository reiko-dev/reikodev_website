import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/ui/pages/home/widgets/animated_arrow.dart';
import 'package:reikodev_website/app/ui/widgets/hover_bottom_animation.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';
import 'package:reikodev_website/app/ui/utils/scroll_data_controller.dart';

class ScrollToDiscoverWidget extends StatefulWidget {
  const ScrollToDiscoverWidget({
    super.key,
  });

  @override
  createState() => _ScrollToDiscoverWidgetState();
}

class _ScrollToDiscoverWidgetState
    extends AnimatedState<ScrollToDiscoverWidget> {
  late final Animation<double> _opacityAnimation;

  late final Animation<double> _shimmerAnimation;
  bool isVisible = false;

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

    init();

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
  }

  init() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    isVisible = true;

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double maxOffsetToShow = size.height * .05;
    return Obx(() {
      final currenTScrollOffset =
          ScrollDataController.i.lastScrollPosition.value;

      if (currenTScrollOffset > maxOffsetToShow) {
        controller.animateBack(0.0);
      } else {
        if (isVisible) {
          controller.forward();
        }
      }
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Visibility(
            visible: _opacityAnimation.value > 0 && isVisible,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: child!,
            ),
          );
        },
        child: RepaintBoundary(
          child: SizedBox(
            width: size.width > 190 ? 190 : size.width,
            height: size.height > 60 ? 60 : size.width,
            child: GestureDetector(
              onTap: () {
                ScrollDataController.i.animateTo(size.height);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
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
                            begin:
                                Alignment(-1 + _shimmerAnimation.value * 4, 0),
                            end: Alignment(1 + _shimmerAnimation.value * 4, 0),
                            tileMode: TileMode.mirror,
                          ).createShader(bounds),
                          child: child!,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: HoverBottomAnimation(
                          text: scrollToDiscover.capitalizeFirst!,
                        ),
                      ),
                    ),
                    const Expanded(child: AnimatedArrow())
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
