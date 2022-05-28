import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class CustomLinkWidget extends StatelessWidget {
  const CustomLinkWidget({
    super.key,
    required this.child,
    required this.uri,
  });

  final Widget child;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return Link(
        uri: uri,
        builder: (c, _) {
          return child;
        });
  }
}
