import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ScrollDataController extends GetxController {
  ScrollDataController._(this._scrollController, this._isMobile);

  factory ScrollDataController() {
    bool isMobile = GetPlatform.isAndroid || GetPlatform.isIOS;

    return ScrollDataController._(
      ScrollController().obs,
      isMobile,
    );
  }

  static final ScrollDataController i = Get.find();

  final Rx<ScrollController> _scrollController;

  final bool _isMobile;
  // your "extra" scroll speed
  static const _extraScrollSpeed = 60;

  final show = true.obs;
  final isAtStart = true.obs;
  final lastScrollPosition = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    _scrollController.value.addListener(_onScrollChanged);
  }

  void animateTo(double offset) {
    _scrollController.value.animateTo(
      offset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInSine,
    );
  }

  ScrollController createNewScroll() {
    _scrollController.value.dispose();
    _scrollController.value = ScrollController();
    init();

    return _scrollController.value;
  }

  void _increaseSpeed(ScrollDirection scrollDirection) {
    double scrollEnd = _scrollController.value.offset +
        (scrollDirection == ScrollDirection.reverse
            ? _extraScrollSpeed
            : -_extraScrollSpeed);
    scrollEnd = min(_scrollController.value.position.maxScrollExtent,
        max(_scrollController.value.position.minScrollExtent, scrollEnd));
    _scrollController.value.jumpTo(scrollEnd);
  }

  void _onScrollChanged() {
    ScrollDirection scrollDirection =
        _scrollController.value.position.userScrollDirection;

    if (scrollDirection != ScrollDirection.idle) {
      if (!_isMobile) {
        _increaseSpeed(scrollDirection);
      }
    }
  }

  void onScrollNotification(ScrollNotification snk) {
    final currentPosition = snk.metrics.pixels;

    if (currentPosition == 0) {
      show.value = true;
      isAtStart.value = true;
    } else {
      isAtStart.value = false;
    }

    if (currentPosition > lastScrollPosition.value) {
      show.value = false;
    } else if (currentPosition < lastScrollPosition.value) {
      show.value = true;
    }

    lastScrollPosition.value = currentPosition;
  }
}
