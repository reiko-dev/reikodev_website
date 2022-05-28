import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reikodev_website/app/ui/pages/background/background_page.dart';
import 'package:reikodev_website/app/ui/pages/home/widgets/widgets.dart';
import 'package:reikodev_website/app/ui/utils/scroll_data_controller.dart';
import 'package:reikodev_website/app/ui/widgets/title_widget.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class PageTemplate extends StatefulWidget {
  const PageTemplate({
    super.key,
    required this.child,
    this.withScrollToDiscover = false,
    this.withLeftPanel = false,
    this.title,
    this.onScrollCallback,
    this.splashScreenDuration,
  });

  final bool withScrollToDiscover, withLeftPanel;

  final String? title;

  final Widget child;

  final void Function(ScrollNotification snk)? onScrollCallback;

  final Duration? splashScreenDuration;

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  final stopAnimationTries = <bool>[];

  double _prevScrollPos = 0;

  double _scrollVel = 0;

  GlobalKey<dynamic>? bgaGkey;

  @override
  void didChangeDependencies() {
    bgaGkey ??= BGAnimator.of(context)?.bgAnimatorKey;
    super.didChangeDependencies();
  }

  void _onScroll(double delta) {
    bgaGkey?.currentState?.onScroll(delta);
  }

  void onItemTap() => bgaGkey?.currentState?.onItemTap();

  bool handleScrollNotification(ScrollNotification snk) {
    ScrollDataController.i.onScrollNotification(snk);

    if (widget.onScrollCallback != null) {
      widget.onScrollCallback!(snk);
    }

    _scrollVel = snk.metrics.pixels - _prevScrollPos;
    _prevScrollPos = snk.metrics.pixels;

    if (snk.metrics.atEdge) {
      _onScroll(0.5);
      return false;
    }

    if (_scrollVel == 0) {
      _stopAnimationWhenEndedToScroll();
    } else {
      _onScroll(_scrollVel);
    }

    return false;
  }

  void _stopAnimationWhenEndedToScroll() {
    ///Necessary when using MOUSE for scrolling purposes.
    stopAnimationTries.add(true);
    Future.delayed(const Duration(milliseconds: 400)).then((value) {
      if (stopAnimationTries.isEmpty) {
        return;
      }

      stopAnimationTries.removeLast();
      if (stopAnimationTries.isEmpty) {
        _onScroll(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox.fromSize(
        size: size,
        child: Center(
          child: NotificationListener<ScrollNotification>(
            onNotification: handleScrollNotification,
            child: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: ScrollDataController.i.createNewScroll(),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        if (widget.title != null)
                          TitleWidget(title: widget.title!),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .05,
                          ),
                          child: widget.child,
                        ),
                        const GoodbyeSection(),
                        const FooterSection(),
                      ],
                    ),
                  ),

                  // Scroll to discover
                  if (widget.withScrollToDiscover)
                    const Align(
                      alignment: Alignment(.85, .95),
                      child: ScrollToDiscoverWidget(),
                    ),

                  //AWWWW left panel
                  if (widget.withLeftPanel && size.width >= 720)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.rotate(
                        angle: -pi / 2,
                        alignment: Alignment.topLeft,
                        child: Container(
                          color: Theme.of(context).colorScheme.background,
                          width: 120,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Reiko - BR.2022",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Theme.of(context).backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  const Header(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
