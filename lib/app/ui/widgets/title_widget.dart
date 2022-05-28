import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  factory TitleWidget(
      {Key? key, required String title, AnimationController? controller}) {
    if (controller == null) {
      return TitleWidget._(key: key, title: title);
    } else {
      return TitleWidget._withController(
          key: key, title: title, controller: controller);
    }
  }

  TitleWidget._withController({
    super.key,
    required this.title,
    required AnimationController controller,
  }) : translateAnim = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(.1, .8, curve: Curves.decelerate),
          ),
        );

  const TitleWidget._({super.key, required this.title}) : translateAnim = null;

  final String title;
  final Animation<double>? translateAnim;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * .13),
      child: SizedBox(
        height: size.height * .22,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * .05,
              horizontal: size.width * .075,
            ),
            child: translateAnim == null
                ? AutoSizeText(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 200),
                  )
                : ClipRect(
                    child: AnimatedBuilder(
                      animation: translateAnim!,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              0,
                              size.height * .17 -
                                  (size.height * .17 * translateAnim!.value)),
                          child: child!,
                        );
                      },
                      child: AutoSizeText(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 200),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
