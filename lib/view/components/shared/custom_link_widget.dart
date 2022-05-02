import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class CustomLinkWidget extends StatelessWidget {
  const CustomLinkWidget.url({
    Key? key,
    required this.url,
    required this.child,
  })  : path = null,
        super(key: key);

  const CustomLinkWidget.path({
    Key? key,
    required this.path,
    required this.child,
  })  : url = null,
        super(key: key);

  final Widget child;
  final String? path;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Link(
        uri: url == null ? Uri(path: path) : Uri.tryParse(url!),
        builder: (c, _) {
          return child;
        });
  }
}
