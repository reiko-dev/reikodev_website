import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// enum ScrollDirection {Forward, Backward}

class ScrollDataController extends GetxController {
  static final ScrollDataController i = Get.find();

  final scrollController = ScrollController().obs;

  // static ScrollDirection direction = ScrollDirection.Backward;
  final direction = ScrollDirection.reverse.obs;

  final position = 0.0.obs;

  static const _extraScrollSpeed = 60; // your "extra" scroll speed

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
      direction.value = scrollDirection;
    }
  }
}
