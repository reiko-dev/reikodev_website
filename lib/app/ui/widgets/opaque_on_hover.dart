import 'package:flutter/material.dart';
import 'package:reikodev_website/app/ui/widgets/inner_shadow.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';

class OpaqueOnHover extends StatefulWidget {
  const OpaqueOnHover({
    super.key,
  });

  @override
  State<OpaqueOnHover> createState() => _OpaqueOnHoverState();
}

class _OpaqueOnHoverState extends AnimatedState<OpaqueOnHover> {
  late final Animation<double> fadeAnimation;
  @override
  void initState() {
    super.initState();
    initController(
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
            color: Theme.of(context).colorScheme.surface,
          )
        ],
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, c) {
              return Image.asset(
                "assets/images/profile.jpg",
                colorBlendMode: BlendMode.color,
                opacity: fadeAnimation,
                color: Theme.of(context)
                    .colorScheme.surface
                    .withOpacity(.6 - (.6 * fadeAnimation.value)),
              );
            }),
      ),
    );
  }
}
