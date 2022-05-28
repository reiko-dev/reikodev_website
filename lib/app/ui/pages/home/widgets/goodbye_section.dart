import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reikodev_website/app/controller/entities/email.dart';
import 'package:reikodev_website/app/controller/link_service.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/ui/utils/scroll_data_controller.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class GoodbyeSection extends StatefulWidget {
  const GoodbyeSection({Key? key}) : super(key: key);

  @override
  State<GoodbyeSection> createState() => _GoodbyeSectionState();
}

class _GoodbyeSectionState extends State<GoodbyeSection> {
  late final TapGestureRecognizer _onTapRecognizer;

  @override
  void initState() {
    _onTapRecognizer = TapGestureRecognizer()..onTap = onTap;
    super.initState();
  }

  void onTap() {
    const email = Email(
      mailTo: reikoEmail,
      bodyContent: "Hey Reiko, i'm contacting you from your website.",
      subject: "Contact",
      person: "you@gmail.com",
    );

    LinkService.sendEmail(email);
  }

  @override
  void dispose() {
    _onTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isVerySmallDesign = size.width < 450;

    return SizedBox(
      width: size.width,
      height: isVerySmallDesign ? size.height * .5 : size.height * .6,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * .05),
              child: SizedBox(
                width: size.width,
                height: size.height * .11,
                child: isVerySmallDesign
                    ? Column(
                        children: [
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _ScrollToTopWidget(),
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, bc) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: bc.maxHeight * .13),
                                      SizedBox(
                                        height: bc.maxHeight * .25,
                                        width: bc.maxWidth * .8,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            lifeIsShort.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: bc.maxHeight * .6,
                                        width: bc.maxWidth * .9,
                                        child: FittedBox(
                                          alignment: Alignment.topLeft,
                                          fit: BoxFit.contain,
                                          child: CustomLinkWidget(
                                            uri: LinkService.getUri(
                                              bodyMailText: "Hey Reiko!",
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                text: reikoEmail,
                                                mouseCursor:
                                                    SystemMouseCursors.click,
                                                recognizer: _onTapRecognizer,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: 50,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, bc) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: bc.maxHeight * .13),
                                      SizedBox(
                                        height: bc.maxHeight * .25,
                                        width: bc.maxWidth * .6,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            lifeIsShort.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: bc.maxHeight * .6,
                                        width: bc.maxWidth * .85,
                                        child: FittedBox(
                                          alignment: Alignment.topLeft,
                                          fit: BoxFit.contain,
                                          child: CustomLinkWidget(
                                            uri: LinkService.getUri(
                                              bodyMailText: "Hey Reiko!",
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                text: reikoEmail,
                                                mouseCursor:
                                                    SystemMouseCursors.click,
                                                recognizer: _onTapRecognizer,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: 50,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _ScrollToTopWidget(),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollToTopWidget extends StatelessWidget {
  const _ScrollToTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          focusColor: Colors.white.withOpacity(.2),
          overlayColor: MaterialStateProperty.resolveWith((state) {
            return Theme.of(context).colorScheme.background.withOpacity(.2);
          }),
          onTap: () {
            ScrollDataController.i.animateTo(0);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                top.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_upward_outlined,
                color: Theme.of(context).textTheme.headline3!.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
