import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/constants.dart';
import 'package:reikodev_website/logic/design_controller.dart';
import 'package:reikodev_website/logic/menu_controller.dart';
import 'package:reikodev_website/logic/animated_state.dart';
import 'package:reikodev_website/logic/scroll_data_controller.dart';
import 'package:reikodev_website/view/components/background_animator.dart';
import 'package:reikodev_website/view/components/custom_link_widget.dart';
import 'package:reikodev_website/view/components/footer_section.dart';
import 'package:reikodev_website/view/components/goodbye_section.dart';
import 'package:reikodev_website/view/components/hover_bottom_animation.dart';
import 'package:reikodev_website/view/components/inner_shadow.dart';
import 'package:reikodev_website/view/components/on_hover_animated.dart';
import 'package:reikodev_website/view/components/scroll_to_discover.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            BackgroundAnimation(key: gKey),
            SectionsList(key: UniqueKey(), bgAnimatorGKey: gKey),
          ],
        ),
      ),
    );
  }
}

class SectionsList extends StatefulWidget {
  const SectionsList({Key? key, required this.bgAnimatorGKey})
      : super(key: key);

  final dynamic bgAnimatorGKey;

  @override
  State<SectionsList> createState() => _SectionsListState();
}

class _SectionsListState extends State<SectionsList> {
  final b = Get.put(DesignController());
  final a = Get.put(MenuController());
  final c = Get.put(ScrollDataController());

  final list = <bool>[];
  double _prevScrollPos = 0;
  double _scrollVel = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DesignController.i.loadDesignType(MediaQuery.of(context).size);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    _scrollVel = notification.metrics.pixels - _prevScrollPos;
    _prevScrollPos = notification.metrics.pixels;

    if (notification.metrics.atEdge) {
      widget.bgAnimatorGKey.currentState!.handleListScroll(0.5);
      return true;
    }

    if (_scrollVel == 0) {
      stopAnimationWhenEndedToScroll();
      return true;
    }

    widget.bgAnimatorGKey.currentState!.handleListScroll(_scrollVel);

    return true;
  }

  ///Necessary when using MOUSE for scrolling purposes.
  void stopAnimationWhenEndedToScroll() {
    list.add(true);
    Future.delayed(const Duration(milliseconds: 400)).then((value) {
      if (list.isEmpty) {
        widget.bgAnimatorGKey.currentState!.handleListScroll(0.0);
        return;
      }

      list.removeLast();
      if (list.isEmpty) {
        widget.bgAnimatorGKey.currentState!.handleListScroll(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox.fromSize(
        size: size,
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: Stack(
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.headline2!,
                child: ListView(
                  controller: ScrollDataController.i.scrollController.value,
                  children: const [
                    HomeSection(),
                    ContentSection(),
                    GoodbyeSection(),
                    FooterSection(),
                  ],
                ),
              ),

              // Scroll to discover
              Align(
                alignment: Alignment.bottomRight,
                child: Obx(() => MenuController.i.isOpen.value
                    ? const SizedBox.shrink()
                    : const ScrollToDiscoverWidget()),
              ),
              const MenuPage(),

              //AWWWW left panel
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Obx(() {
                    return DesignController.i.type.value == DesignType.mobile
                        ? const SizedBox.shrink()
                        : Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, 40.0)
                              ..rotateZ(-pi / 2),
                            child: Text(
                              "Reiko - BR.2022",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          );
                  }),
                ),
              ),
              const Header(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  const ContentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Projects section
        Column(
          children: [
            SizedBox(
              height: size.height * .27,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: padding.copyWith(top: 0, bottom: 0),
                  child: Text(
                    "PROJECTS",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: size.width * .1),
                  ),
                ),
              ),
            ),
            const OnHoverAnimated(
              color: Colors.red,
              bottomText: "Developer/Designer",
              buttonText: "Memory Game",
            ),
            const OnHoverAnimated(
              color: Colors.blueGrey,
              bottomText: "Developer/Designer/Vacation",
              buttonText: "DFT Painter",
              asset: "assets/images/dft_in_action.gif",
            ),
            const OnHoverAnimated(
              color: Colors.amber,
              buttonText: "BitLock Mini",
              bottomText: "PRODUCT DESIGN/ INDUSTRIAL DESIGN/ PACKAGE DESIGN",
            ),
            Obx(() {
              return DesignController.i.type.value == DesignType.mobile
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: padding,
                          child: GestureDetector(
                            onTap: () {
                              print("More... clicked!!");
                            },
                            child: const MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text("More..."),
                            ),
                          )),
                    );
            }),
          ],
        ),

        //Gallery section
        SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: size.height * .27,
                  child: Padding(
                    padding: padding.copyWith(bottom: 0, top: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "GALLERY",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * .1,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .8,
                child: Padding(
                  padding: padding.copyWith(bottom: 0, top: 0),
                  child: Stack(
                    children: [
                      Container(color: Colors.blueGrey),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: .14,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.grey.withOpacity(.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "VISIT THE GALLERY",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Icon(Icons.arrow_forward,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context)
        .textTheme
        .headline1!
        .copyWith(fontSize: size.width * .1);

    return Obx(() {
      return !MenuController.i.isOpen.value ||
              DesignController.i.type.value == DesignType.desktop
          ? const SizedBox.shrink()
          : Center(
              child: Container(
                width: size.width,
                height: size.height,
                color: const Color(0xDF151515),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(flex: 5),
                    HoverBottomAnimation(text: "HOME", style: style),
                    const Spacer(flex: 2),
                    HoverBottomAnimation(text: "PROJECTS", style: style),
                    const Spacer(flex: 2),
                    HoverBottomAnimation(text: "ABOUT", style: style),
                    const Spacer(flex: 2),
                    HoverBottomAnimation(text: "CONTACT", style: style),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            );
    });
  }
}

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool hide = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ScrollDataController.i.direction.value != ScrollDirection.reverse ||
        ScrollDataController.i.position.value == 0) {
      hide = false;
    } else {
      hide = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return hide
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
  }
}

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

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height * .7,
              maxWidth: size.width * .5,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: AspectRatio(
                aspectRatio: .75,
                child: LayoutBuilder(
                  builder: (context, bc) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: const OpaqueOnHover(),
                    );
                  },
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * .5,
                width: size.width * .3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Center(
                    child: AutoSizeText.rich(
                      const TextSpan(
                          text: 'Information Systems Analyst',
                          children: [
                            TextSpan(text: "\nFlutter Lover\u{1F499}"),
                          ]),
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: size.width * .05),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      wrapWords: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OpaqueOnHover extends StatefulWidget {
  const OpaqueOnHover({
    Key? key,
  }) : super(key: key);

  @override
  State<OpaqueOnHover> createState() => _OpaqueOnHoverState();
}

class _OpaqueOnHoverState extends AnimatedState<OpaqueOnHover> {
  late final Animation<double> fadeAnimation;
  @override
  void initState() {
    super.initState();
    init(
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
            color: Theme.of(context).backgroundColor,
          )
        ],
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, c) {
              return Image.asset(
                "assets/images/profile2.jpg",
                colorBlendMode: BlendMode.color,
                opacity: fadeAnimation,
                color: Theme.of(context)
                    .backgroundColor
                    .withOpacity(.6 - (.6 * fadeAnimation.value)),
              );
            }),
      ),
    );
  }
}
