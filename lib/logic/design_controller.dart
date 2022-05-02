import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DesignType { mobile, desktop }

class DesignController extends GetxController {
  static final DesignController i = Get.find();
  final type = DesignType.desktop.obs;

  void loadDesignType(Size size) {
    if (size.width < 720) {
      type.value = DesignType.mobile;
    } else {
      type.value = DesignType.desktop;
    }
  }
}
