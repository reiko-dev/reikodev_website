import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reikodev_website/constants.dart';

import 'package:url_strategy/url_strategy.dart';

import 'package:reikodev_website/view/pages/about_page.dart';
import 'package:reikodev_website/view/pages/home_page.dart';

void main() {
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  if (kIsWeb) {
    setPathUrlStrategy();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void updateUiBars() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent, // status bar color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateUiBars();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: customThemeData,
      home: const HomePage(),
      routes: {
        AboutPage.routeName: (_) => const AboutPage(),
      },
    );
  }
}
