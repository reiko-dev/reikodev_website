import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:visibility_detector/visibility_detector.dart';

import 'package:reikodev_website/app/controller/entities/experience.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

const String experienceAssetsBasePath = "assets/images/experiences/";

class TimeLineItem extends StatefulWidget {
  const TimeLineItem({super.key, required this.experience});

  final Experience experience;

  @override
  State<TimeLineItem> createState() => _TimeLineItemState();
}

class _TimeLineItemState extends AnimatedState<TimeLineItem> {
  final greyColor = const Color(0xFFD4D4D4);

  @override
  void initState() {
    initController(duration: const Duration(milliseconds: 500));
    initAnimation(
        tween: Tween<double>(begin: 0, end: 1), curve: Curves.easeOutExpo);
    super.initState();
  }

  void animateTo(double newVal) {
    if (controller.isAnimating) {
      controller.stop();
    }
    controller.animateTo(newVal);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    final dateStyle = textTheme.headline1!.copyWith(
      fontWeight: FontWeight.bold,
      color: greyColor,
    );

    final h2Style = textTheme.headline3!.copyWith(
      fontWeight: FontWeight.bold,
      color: greyColor,
    );
    final h3Style = textTheme.headline4!.copyWith(
      color: greyColor,
    );
    final bodyTextStyle = textTheme.headline5!.copyWith(
      color: const Color(0xFFbebebe),
      fontSize: 15,
    );

    return VisibilityDetector(
      key: ValueKey(widget.experience.id),
      onVisibilityChanged: (info) {
        if (!mounted) return;
        final box = context.findRenderObject() as RenderBox;
        final globalOffset = box.localToGlobal(box.semanticBounds.topLeft);

        if (globalOffset.dy <= 0) {
          animateTo(1);
        } else {
          animateTo(info.visibleFraction);
        }
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final angle = (1 - controller.value) * -pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle)
              ..translate(0.0, 100.0 * (1 - controller.value)),
            alignment: Alignment.center,
            child: Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: controller.value > 0,
              child: ImageFiltered(
                enabled: controller.value < .5,
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: child!,
              ),
            ),
          );
        },
        child: size.width < 720
            ? Center(
                child: SizedBox(
                  width: size.width * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.experience.city.toUpperCase(),
                        style: h3Style,
                      ),
                      Text(
                        widget.experience.date.toUpperCase(),
                        style: dateStyle,
                      ),
                      Text(
                        widget.experience.context.toUpperCase(),
                        style: h2Style,
                      ),
                      const SizedBox(height: 20),
                      if (widget.experience.moreInfo != null)
                        Text(
                          widget.experience.moreInfo!,
                          style: bodyTextStyle,
                        ),
                      if (widget.experience.moreInfo != null)
                        const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: size.width * .8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              experienceAssetsBasePath +
                                  widget.experience.imageURL,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Row(
                key: UniqueKey(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Left elements
                  SizedBox(
                    width: size.width * .35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.experience.city.toUpperCase(),
                          style: h3Style,
                        ),
                        Text(
                          widget.experience.date.toUpperCase(),
                          style: dateStyle,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  //Right elements
                  SizedBox(
                    width: size.width * .35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.experience.context.toUpperCase(),
                          style: h2Style,
                        ),
                        const SizedBox(height: 20),
                        if (widget.experience.moreInfo != null)
                          Text(
                            widget.experience.moreInfo!,
                            style: bodyTextStyle,
                          ),
                        if (widget.experience.moreInfo != null)
                          const SizedBox(height: 20),
                        SizedBox(
                          width: size.width * .35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              experienceAssetsBasePath +
                                  widget.experience.imageURL,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
