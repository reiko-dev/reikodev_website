import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.value == .5) {
          _controller.animateBack(.0);
          return;
        }
        if (_controller.value == 0) {
          _controller.animateTo(.5);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Lottie.asset(
          'assets/lottie/theme-mode-animation.json',
          height: 35,
          controller: _controller,
          reverse: false,
          repeat: false,
          onLoaded: (composition) {},
        ),
      ),
    );
  }
}
