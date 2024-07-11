import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/ui/utils/menu_controller.dart' as mc;
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({
    super.key,
  });

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
      if (mc.MenuController.i.isOpen.value) {
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
              if (mc.MenuController.i.isOpen.value) {
                mc.MenuController.i.isOpen.value = false;
                controller.reverse();
              } else {
                mc.MenuController.i.isOpen.value = true;
                await controller.forward();
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(.8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  size: 28,
                  color: Theme.of(context).colorScheme.surface,
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
