// ignore_for_file: avoid_print

import 'package:reikodev_website/app/controller/entities/email.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class LinkService {
  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> sendEmail(Email email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email.mailTo,
      query: _encodeQueryParameters(<String, String>{
        'subject': email.subject,
        'body': email.bodyContent,
      }),
    );

    if (await launcher.canLaunchUrl(emailUri)) {
      await launcher.launchUrl(emailUri);
    }
  }

  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);

    if (await launcher.canLaunchUrl(uri)) {
      await launcher.launchUrl(uri);
    }
  }

  static Uri getUri({String? bodyMailText, String? url, String? path}) {
    assert(
      bodyMailText != null || url != null || path != null,
      "Can't create URI from the data passed.",
    );

    if (bodyMailText != null) {
      return Uri(
          scheme: 'mailto',
          path: reikoEmail,
          queryParameters: {'subject': bodyMailText});
    }

    if (url == null) {
      return Uri(path: path);
    }

    return Uri.tryParse(url)!;
  }
}
