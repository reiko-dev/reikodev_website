import 'package:flutter/material.dart';
import 'package:reikodev_website/logic/animated_state.dart';
import 'package:reikodev_website/view/components/shared/inner_shadow.dart';

class OpaqueOnHover extends StatefulWidget {
  const OpaqueOnHover({
    Key? key,
  }) : super(key: key);

  @override
  State<OpaqueOnHover> createState() => _OpaqueOnHoverState();
}

class _OpaqueOnHoverState extends AnimatedState<OpaqueOnHover> {
  late final Animation<double> fadeAnimation;
  @override
  void initState() {
    super.initState();
    init(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 300),
    );

    fadeAnimation = Tween<double>(begin: .92, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        controller.forward(from: 0);
      },
      onExit: (_) {
        controller.reverse(from: 1);
      },
      child: InnerShadow(
        shadows: [
          BoxShadow(
            blurRadius: 120,
            spreadRadius: 10,
            color: Theme.of(context).backgroundColor,
          )
        ],
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, c) {
              return Image.asset(
                "assets/images/profile2.jpg",
                colorBlendMode: BlendMode.color,
                opacity: fadeAnimation,
                color: Theme.of(context)
                    .backgroundColor
                    .withOpacity(.6 - (.6 * fadeAnimation.value)),
              );
            }),
      ),
    );
  }
}
