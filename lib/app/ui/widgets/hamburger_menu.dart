import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/ui/utils/menu_controller.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends AnimatedState<HamburgerMenu> {
  @override
  void initState() {
    super.initState();
    initController(
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (MenuController.i.isOpen.value) {
        controller.forward(from: 0);
      } else {
        controller.reverse(from: 1);
      }
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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background.withOpacity(.8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  size: 28,
                  color: Theme.of(context).backgroundColor,
                  progress: controller,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
