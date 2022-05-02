// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:reikodev_website/entities/email.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationController extends ChangeNotifier {
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> sendEmail(Email email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email.mailTo,
      query: encodeQueryParameters(<String, String>{
        'subject': email.subject,
        'body': email.bodyContent,
      }),
    );

    if (!await launch(emailUri.toString())) {
      print("URL launch error");
    }
  }

  static Future<void> launchUrl(String url) async {
    if (!await launch(url)) {
      print("URL launch error");
    }
  }
}
