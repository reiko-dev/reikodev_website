import 'package:flutter/material.dart';
import 'package:reikodev_website/logic/animated_state.dart';
import 'package:reikodev_website/logic/menu_controller.dart';

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends AnimatedState {
  @override
  void initState() {
    super.initState();
    init(
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MenuController.i.isOpen.value) {
      controller.value = 1;
    } else {
      controller.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.square(48),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            if (MenuController.i.isOpen.value) {
              MenuController.i.isOpen.value = false;
              controller.reverse();
            } else {
              MenuController.i.isOpen.value = true;
              await controller.forward();
            }
          },
          child: DecoratedBox(
            decoration: const BoxDecoration(
              // color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                size: 28,
                color: Colors.white,
                progress: controller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
