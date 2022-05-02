import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/internationalization.dart';
import 'package:reikodev_website/logic/design_controller.dart';
import 'package:reikodev_website/logic/navigation_controller.dart';
import 'package:reikodev_website/view/components/custom_link_widget.dart';
import 'package:reikodev_website/view/components/custom_selectable_text.dart';
import 'package:reikodev_website/view/components/hover_bottom_animation.dart';
import 'package:reikodev_website/view/components/on_hover_icon.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetsList = [
      const _CodeByReiko(),
      const Expanded(
        flex: 2,
        child: AnimatedSocialMedia(),
      ),
      const _LegalWidgets(),
    ];

    final Size _size = MediaQuery.of(context).size;
    return Obx(() {
      final isMobile = DesignController.i.type.value == DesignType.mobile;
      late double height;
      if (isMobile) {
        height = 280;
      } else {
        height = _size.height * .2 < 170 ? 170 : _size.height * .2;
      }
      final width = _size.width;

      return Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.white.withOpacity(.02),
                ),
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.black.withAlpha(40),
                  border: const Border(
                    top: BorderSide(width: .5, color: Colors.white),
                  )),
              child: isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(),
                        ...widgetsList,
                        const Spacer(),
                      ],
                    )
                  : Row(
                      children: [
                        widgetsList[0],
                        widgetsList[2],
                        widgetsList[1],
                      ],
                    ),
            ),
          ),
        ],
      );
    });
  }
}

class _LegalWidgets extends StatelessWidget {
  const _LegalWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _CustomSelectableText(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 27,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomLinkWidget.path(
                    path: "terms-and-conditions",
                    child: HoverBottomAnimation(
                      text: "Terms & Conditions",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  const VerticalDivider(),
                  CustomLinkWidget.path(
                    path: "privacy-policy",
                    child: HoverBottomAnimation(
                      text: "Privacy Policy",
                      style: Theme.of(context).textTheme.subtitle1,
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

class _CustomSelectableText extends StatefulWidget {
  const _CustomSelectableText({
    Key? key,
  }) : super(key: key);

  @override
  State<_CustomSelectableText> createState() => _CustomSelectableTextState();
}

class _CustomSelectableTextState extends State<_CustomSelectableText> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.blue,
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subtitle1!,
        child: const CustomSelectableText(copyrightsTxt),
      ),
    );
  }
}

class _CodeByReiko extends StatelessWidget {
  const _CodeByReiko({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Text(
          "© Code by Reiko".toUpperCase(),
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class AnimatedSocialMedia extends StatefulWidget {
  const AnimatedSocialMedia({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedSocialMedia> createState() => _AnimatedSocialMediaState();
}

class _AnimatedSocialMediaState extends State<AnimatedSocialMedia> {
  bool isHovering = false;
  MouseCursor cursor = SystemMouseCursors.basic;

  final iconPadding = const EdgeInsets.symmetric(vertical: 2, horizontal: 10);

  void setIsHovering(bool isHovering) {
    if (isHovering == this.isHovering) return;

    this.isHovering = isHovering;

    if (isHovering) {
      cursor = SystemMouseCursors.click;
    } else {
      cursor = SystemMouseCursors.basic;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 25,
        ),
        child: Center(
          child: MouseRegion(
            onHover: (_) => setIsHovering(true),
            onExit: (_) => setIsHovering(false),
            cursor: cursor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                OnHoverIcon(
                  iconData: EvaIcons.facebook,
                  padding: iconPadding,
                  linkText: "https://www.facebook.com/Lucascordovil",
                  onHoverColor: Colors.white,
                  onClick: () {
                    NavigationController.launchUrl(
                      "https://www.facebook.com/Lucascordovil",
                    );
                  },
                ),
                OnHoverIcon(
                  iconData: EvaIcons.github,
                  padding: iconPadding,
                  linkText: "https://github.com/reiko-dev",
                  onHoverColor: Colors.white,
                  onClick: () {
                    NavigationController.launchUrl(
                      "https://github.com/reiko-dev",
                    );
                  },
                ),
                OnHoverIcon(
                  iconData: EvaIcons.linkedin,
                  padding: iconPadding,
                  linkText: "https://linkedin.com/in/reiko-dev",
                  onHoverColor: Colors.white,
                  onClick: () {
                    NavigationController.launchUrl(
                      "https://linkedin.com/in/reiko-dev",
                    );
                  },
                ),
                OnHoverIcon(
                  iconData: EvaIcons.twitter,
                  padding: iconPadding,
                  linkText: "https://twitter.com/reiko_dev",
                  onHoverColor: Colors.white,
                  onClick: () {
                    NavigationController.launchUrl(
                      "https://twitter.com/reiko_dev",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
