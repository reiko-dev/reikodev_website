import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// enum ScrollDirection {Forward, Backward}

class ScrollDataController extends GetxController {
  static final ScrollDataController i = Get.find();

  final scrollController = ScrollController().obs;

  final direction = AxisDirection.up.obs;

  final position = 0.0.obs;

  static const _extraScrollSpeed = 60; // your "extra" scroll speed

  final show = true.obs;
  final lastScrollPosition = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    final isMobile = GetPlatform.isAndroid || GetPlatform.isIOS;
    scrollController.value.addListener(() => _onScrollChanged(isMobile));
  }

  void _increaseSpeed(ScrollDirection scrollDirection) {
    double scrollEnd = scrollController.value.offset +
        (scrollDirection == ScrollDirection.reverse
            ? _extraScrollSpeed
            : -_extraScrollSpeed);
    scrollEnd = min(scrollController.value.position.maxScrollExtent,
        max(scrollController.value.position.minScrollExtent, scrollEnd));
    scrollController.value.jumpTo(scrollEnd);
  }

  void _onScrollChanged(bool isMobile) {
    ScrollDirection scrollDirection =
        scrollController.value.position.userScrollDirection;
    if (scrollDirection != ScrollDirection.idle) {
      if (!isMobile) {
        _increaseSpeed(scrollDirection);
      }
    }
  }

  void onScrollNotification(ScrollNotification snk) {
    final currentDirection = snk.metrics.axisDirection;
    final currentPosition = snk.metrics.pixels;

    if (currentPosition == 0) show.value = true;

    if (currentPosition > lastScrollPosition.value) {
      show.value = false;
    } else if (currentPosition < lastScrollPosition.value) {
      show.value = true;
    }

    lastScrollPosition.value = currentPosition;
    direction.value = currentDirection;
  }
}
