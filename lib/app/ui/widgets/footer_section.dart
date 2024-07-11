import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/controller/link_service.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

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

    final Size size = MediaQuery.of(context).size;

    final isMobile = size.width < 720;
    late double height;
    if (isMobile) {
      height = 280;
    } else {
      height = size.height * .2 < 170 ? 170 : size.height * .2;
    }
    final width = size.width;

    return Stack(
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: SizedBox(
                width: width,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.25),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: width,
          height: height,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(width: .3, color: Colors.white),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
  }
}

class _LegalWidgets extends StatelessWidget {
  const _LegalWidgets();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSelectableText(
              copyrightsTxt,
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 27,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomLinkWidget(
                    uri: LinkService.getUri(path: "terms-and-conditions"),
                    child: HoverBottomAnimation(
                      text: "Terms & Conditions",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const VerticalDivider(),
                  CustomLinkWidget(
                    uri: LinkService.getUri(path: "privacy-policy"),
                    child: HoverBottomAnimation(
                      text: "Privacy Policy",
                      style: Theme.of(context).textTheme.titleMedium,
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

class _CodeByReiko extends StatelessWidget {
  const _CodeByReiko();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            codeByReiko.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

class AnimatedSocialMedia extends StatefulWidget {
  const AnimatedSocialMedia({
    super.key,
  });

  @override
  State<AnimatedSocialMedia> createState() => _AnimatedSocialMediaState();
}

class _AnimatedSocialMediaState extends State<AnimatedSocialMedia> {
  final iconPadding = const EdgeInsets.symmetric(vertical: 2, horizontal: 10);

  @override
  Widget build(BuildContext context) {
    final hoverColor = Theme.of(context).hoverColor;

    return RepaintBoundary(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 25,
          ),
          child: Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnHoverIcon(
                    iconData: EvaIcons.facebook,
                    padding: iconPadding,
                    linkText: "https://www.facebook.com/Lucascordovil",
                    onHoverColor: hoverColor,
                    onClick: () async {
                      await LinkService.launchURL(
                        "https://www.facebook.com/Lucascordovil",
                      );
                    },
                  ),
                  OnHoverIcon(
                    iconData: EvaIcons.github,
                    padding: iconPadding,
                    linkText: "https://github.com/reiko-dev",
                    onHoverColor: hoverColor,
                    onClick: () {
                      LinkService.launchURL(
                        "https://github.com/reiko-dev",
                      );
                    },
                  ),
                  OnHoverIcon(
                    iconData: EvaIcons.linkedin,
                    padding: iconPadding,
                    linkText: "https://linkedin.com/in/reiko-dev",
                    onHoverColor: hoverColor,
                    onClick: () {
                      LinkService.launchURL(
                        "https://linkedin.com/in/reiko-dev",
                      );
                    },
                  ),
                  OnHoverIcon(
                    iconData: EvaIcons.twitter,
                    padding: iconPadding,
                    linkText: "https://twitter.com/reiko_dev",
                    onHoverColor: hoverColor,
                    onClick: () {
                      LinkService.launchURL(
                        "https://twitter.com/reiko_dev",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
