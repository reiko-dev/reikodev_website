import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:reikodev_website/app/controller/link_service.dart';
import 'package:reikodev_website/app/index.dart';
import 'package:reikodev_website/app/routes/routes.dart';
import 'package:reikodev_website/app/ui/extensions.dart';

import 'package:reikodev_website/app/ui/utils/constants.dart';
import 'package:reikodev_website/app/ui/utils/scroll_data_controller.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class Header extends StatefulWidget {
  const Header({
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends AnimatedState<Header> {
  bool isFirstBuild = true;
  @override
  void initState() {
    super.initState();
    initController(duration: const Duration(milliseconds: 350));
  }

  void animateForward() async {
    if (isFirstBuild) {
      await Future.delayed(const Duration(milliseconds: 1500));
      controller.forward();
      isFirstBuild = false;
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      if (ScrollDataController.i.show.value) {
        animateForward();
      } else {
        controller.animateBack(0.0);
      }

      return Stack(
        children: [
          const MenuElement(),
          AnimatedBuilder(
            animation: controller,
            builder: (_, child) {
              return Visibility(
                visible: controller.value > 0,
                child: Transform(
                  transform: Matrix4.identity()
                    ..rotateX(pi * .2 - pi * .2 * controller.value),
                  child: Opacity(
                    opacity: controller.value,
                    child: child!,
                  ),
                ),
              );
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: size.height * .13 > 83 ? 83 : size.height * .13,
                width: size.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ScrollDataController.i.isAtStart.value
                        ? null
                        : Colors.black26,
                  ),
                  child: Padding(
                    padding: padding.copyWith(
                      top: 0,
                      bottom: 0,
                      // left: padding.left * 1.5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onLongPress: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final service = Get.find<AppVersionService>();

                            final snackBar = SnackBar(
                                content: Align(
                              alignment: const Alignment(0, -.2),
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Version:'),
                                      const SizedBox(height: 12),
                                      Text(service.version)
                                    ],
                                  ),
                                ),
                              ),
                            ));
                            messenger.showSnackBar(snackBar);
                          },
                          child: Text(
                            size.width < 720 ? "REIKO" : "Code By REIKO",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        size.width <= 720
                            ? const HamburgerMenu()
                            : const _MenuItens()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _MenuItens extends StatelessWidget {
  const _MenuItens();

  void toRoute({
    required Routes newRoute,
    required String currentLocation,
    required BuildContext context,
  }) {
    if (newRoute.location != currentLocation) {
      context.goNamed(newRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineSmall!,
      child: SizedBox(
        width: 260,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HoverBottomAnimation(
              text: "Home",
              link: LinkService.getUri(path: Routes.home.location),
              onTap: () => toRoute(
                context: context,
                currentLocation: location,
                newRoute: Routes.home,
              ),
            ),
            HoverBottomAnimation(
              text: "Work",
              link: LinkService.getUri(path: Routes.projects.location),
              onTap: () => toRoute(
                context: context,
                currentLocation: location,
                newRoute: Routes.projects,
              ),
            ),
            HoverBottomAnimation(
              link: LinkService.getUri(path: Routes.about.location),
              text: "About",
              onTap: () => toRoute(
                context: context,
                currentLocation: location,
                newRoute: Routes.about,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
