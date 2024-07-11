import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/routes/routes.dart';
import 'package:reikodev_website/app/ui/extensions.dart';
import 'package:reikodev_website/app/ui/theme.dart';
import 'package:reikodev_website/app/ui/utils/menu_controller.dart' as mc;
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';
import 'package:reikodev_website/app/ui/widgets/hover_bottom_animation.dart';

class MenuElement extends StatefulWidget {
  const MenuElement({super.key});

  @override
  State<MenuElement> createState() => _MenuElementState();
}

class _MenuElementState extends AnimatedState<MenuElement> {
  String? currentRouteName;

  @override
  void initState() {
    super.initState();
    initController(duration: const Duration(milliseconds: 100));
    initAnimation(
      tween: Tween<double>(begin: 0, end: 1),
      begin: .75,
      end: 1,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void onTap(String nextRouteName) {
    mc.MenuController.i.isOpen.value = false;
    controller.reverse(from: 1);
    if (currentRouteName != nextRouteName) {
      context.goNamed(nextRouteName);
    }
  }

  @override
  Widget build(BuildContext context) {
    currentRouteName = GoRouter.of(context).location.substring(1);
    final shades = Theme.of(context).extension<ShadeStyle>()!;
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context)
        .textTheme
        .displayLarge!
        .copyWith(fontSize: size.width * .1);

    return Obx(() {
      if (!mc.MenuController.i.isOpen.value || size.width > 720) {
        controller.reverse();
      } else {
        controller.forward();
      }

      return Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Visibility(
                  visible: controller.value > 0,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: shades.primary
                                .withOpacity(.95 * animation!.value),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * (.5 + controller.value / 2),
                        child: Opacity(
                          opacity: controller.value,
                          child: child!,
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(flex: 8),
                  HoverBottomAnimation(
                    text: home.capitalizeFirst!,
                    style: style.copyWith(
                      color: currentRouteName == Routes.home.name
                          ? shades.primaryLight
                          : null,
                    ),
                    onTap: () => onTap(Routes.home.name),
                  ),
                  const Spacer(),
                  HoverBottomAnimation(
                    text: work.capitalizeFirst!,
                    style: style.copyWith(
                      color: currentRouteName == Routes.projects.name
                          ? shades.primaryLight
                          : null,
                    ),
                    onTap: () => onTap(Routes.projects.name),
                  ),
                  const Spacer(),
                  HoverBottomAnimation(
                    text: about.capitalizeFirst!,
                    style: style.copyWith(
                      color: currentRouteName == Routes.about.name
                          ? shades.primaryLight
                          : null,
                    ),
                    onTap: () => onTap(Routes.about.name),
                  ),
                  const Spacer(flex: 10),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
