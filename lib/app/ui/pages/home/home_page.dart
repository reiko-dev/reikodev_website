import 'package:flutter/material.dart';
import 'package:reikodev_website/app/routes/app_page_routes.dart';

import 'package:reikodev_website/app/ui/pages/home/widgets/widgets.dart';
import 'package:reikodev_website/app/ui/pages/page_template.dart';
import 'package:reikodev_website/app/ui/widgets/splash_animation/splash_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const splashScreenDuration = Duration(milliseconds: 2500);

  bool isFirstBuild = true;

  @override
  void didChangeDependencies() {
    isFirstBuild = Pages.isFirstBuild;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageTemplate(
          withScrollToDiscover: true,
          withLeftPanel: true,
          splashScreenDuration: splashScreenDuration,
          child: Column(
            children: [
              ProfileSection(
                splashScreenDuration:
                    isFirstBuild ? splashScreenDuration : Duration.zero,
              ),
              const ContentSection(),
            ],
          ),
        ),
        if (isFirstBuild)
          const SplashAnimation(
            duration: splashScreenDuration,
          ),
      ],
    );
  }
}
