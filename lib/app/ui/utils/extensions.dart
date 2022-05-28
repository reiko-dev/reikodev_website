import 'package:flutter/material.dart';

extension StringExtension on String {
  String get capitalizeFirst {
    return substring(0, 1).toUpperCase() + substring(1);
  }
}

extension M on MediaQuery {
  static Size size(context) {
    return MediaQuery.of(context).size;
  }
}
