import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/constants.dart';
import 'package:reikodev_website/logic/design_controller.dart';
import 'package:reikodev_website/logic/scroll_data_controller.dart';
import 'package:reikodev_website/view/components/shared/custom_link_widget.dart';
import 'package:reikodev_website/view/components/shared/hover_bottom_animation.dart';
import 'package:reikodev_website/view/components/shared/hamburger_menu.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      return !ScrollDataController.i.show.value
          ? const SizedBox.shrink()
          : Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.black45,
                height: size.height * .13 > 83 ? 83 : size.height * .13,
                width: size.width,
                child: Padding(
                  padding: padding.copyWith(top: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(() {
                        return Text(
                          DesignController.i.type.value == DesignType.mobile
                              ? "REIKO"
                              : "Code By REIKO",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                      size.width <= 720
                          ? const HamburgerMenu()
                          : DefaultTextStyle(
                              style: Theme.of(context).textTheme.headline5!,
                              child: SizedBox(
                                width: 260,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    CustomLinkWidget.path(
                                      path: "work",
                                      child: HoverBottomAnimation(
                                        text: "Work",
                                      ),
                                    ),
                                    CustomLinkWidget.path(
                                      path: "about",
                                      child: HoverBottomAnimation(
                                        text: "About",
                                      ),
                                    ),
                                    CustomLinkWidget.path(
                                      path: "contact",
                                      child: HoverBottomAnimation(
                                        text: "Contact",
                                      ),
                                    ),
                                    // ThemeSwitcher(),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
