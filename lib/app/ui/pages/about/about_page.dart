import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/experience_controller.dart';
import 'package:reikodev_website/app/controller/expertises_controller.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/data/repository/experiences_repository_impl.dart';
import 'package:reikodev_website/app/data/repository/expertises_repository_imp.dart';
import 'package:reikodev_website/app/ui/pages/about/floating_flag_text.dart';
import 'package:reikodev_website/app/ui/pages/about/expertise_widget.dart';
import 'package:reikodev_website/app/ui/pages/about/profile_image.dart';
import 'package:reikodev_website/app/ui/pages/about/timeline.dart';
import 'package:reikodev_website/app/ui/pages/page_template.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void didChangeDependencies() {
    precacheImage(
      const AssetImage("assets/images/profile/profile_grayscale.jpg"),
      context,
    );
    super.didChangeDependencies();
  }

  final e = Get.put(ExperienceController(ExperiencesRepositoryImpl()));
  final h = Get.put(ExpertisesController(ExpertisesRepositoryImpl()));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isFlaggedDesign = size.width > 480;

    return PageTemplate(
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            const ProfileImage(),
            SizedBox(height: size.height * .15),
            if (isFlaggedDesign) ...[
              const FloatingFlagText(
                text: "Mindset",
                child: _InitialText(),
              ),
              SizedBox(height: size.height * .15),
              const FloatingFlagText(
                text: "Experience",
                child: TimeLine(),
              ),
              SizedBox(height: size.height * .15),
              const FloatingFlagText(
                text: "Expertise",
                child: ExpertiseWidget(),
              ),
            ],
            if (!isFlaggedDesign) ...[
              const _InitialText(),
              SizedBox(height: size.height * .15),
              const TimeLine(),
              SizedBox(height: size.height * .15),
              const ExpertiseWidget(),
            ],
            SizedBox(height: size.height * .3),
          ],
        ),
      ),
    );
  }
}

class _InitialText extends StatelessWidget {
  const _InitialText();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.displayLarge!.copyWith(
      color: const Color(0xFFD3D4C9),
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );

    final bodyTextStyle = textTheme.headlineMedium!.copyWith(
      color: const Color(0xFFD3D4C9),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .05),
      child: Center(
        child: size.width < 720
            ? Column(
                children: [
                  SizedBox(
                    height: size.height * .155,
                    child: Text(
                      mindset.toUpperCase(),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: titleStyle,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    child: Text(
                      aboutText,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: bodyTextStyle,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: size.height * .35,
                      child: AutoSizeText(
                        mindset.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: titleStyle.copyWith(
                          color: const Color(0xFFD3D4C9),
                          letterSpacing: -1,
                          wordSpacing: -3,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .1),
                  Expanded(
                    child: Text(
                      aboutText,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: const Color.fromARGB(255, 211, 212, 201),
                              ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
