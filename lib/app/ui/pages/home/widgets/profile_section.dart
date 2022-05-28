import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reikodev_website/app/controller/entities/email.dart';
import 'package:reikodev_website/app/controller/link_service.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/ui/pages/home/widgets/full_screen_widget.dart';
import 'package:reikodev_website/app/ui/widgets/widgets.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key, required this.splashScreenDuration});

  final Duration splashScreenDuration;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends AnimatedState<ProfileSection> {
  final textKey = GlobalKey();
  Size? textSize;
  int? rowsNumber;
  bool isLoadingText = false;

  @override
  void initState() {
    initController(duration: const Duration(milliseconds: 2000));
    initAnimation(
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeInOutQuad,
      begin: 0,
      end: .5,
    );

    super.initState();

    loadTextData().then((_) {
      runTextAnimation();
    });
  }

  void runTextAnimation() async {
    late Duration delayedTime;
    if (widget.splashScreenDuration == Duration.zero) {
      delayedTime = const Duration(milliseconds: 1500);
    } else {
      delayedTime =
          widget.splashScreenDuration - const Duration(milliseconds: 150);
    }

    await Future.delayed(delayedTime);

    if (!controller.isAnimating && mounted) {
      controller.value = 0;
      controller.forward();
    }
  }

  Future<void> loadTextData() async {
    if (isLoadingText) return;

    isLoadingText = true;
    Completer c = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final r = textKey.currentContext!.findRenderObject() as RenderParagraph;
      final text = r.text.toPlainText();

      int rows = 0;

      final textBoxes = r.getBoxesForSelection(
        TextSelection(baseOffset: 0, extentOffset: text.length),
      );

      //If the textBox start with left == 0, it's a new line.
      for (var box in textBoxes) {
        if (box.left == 0) rows++;
      }

      setState(() {
        rowsNumber = rows;
        textSize = r.textSize;
      });
      c.complete();
      isLoadingText = false;
    });

    return c.future;
  }

  @override
  void didChangeDependencies() {
    loadTextData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 200,
        );

    return Center(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: SizedBox(
            width: size.width * .8,
            height: size.height * .4,
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        // color: Colors.green,
                        height: size.height * .3,
                        width: size.width * .8,
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return RevealingTextAnimation(
                              totalRows: rowsNumber,
                              animValue: animation!.value as double,
                              textSize: textSize ?? Size.zero,
                              child: child!,
                            );
                          },
                          child: AutoSizeText.rich(
                            textKey: textKey,
                            TextSpan(
                              text: homeIntro1 + " ",
                              children: [
                                TextSpan(
                                  text: reikoVitorLucas,
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ", " + homeIntro2,
                                  style: style.copyWith(
                                    color: style.color!.withOpacity(.35),
                                  ),
                                ),
                              ],
                            ),
                            // stepGranularity: 2,
                            textAlign: TextAlign.justify,

                            style: style.copyWith(
                              color: style.color!.withOpacity(.35),
                              leadingDistribution: TextLeadingDistribution.even,
                              fontSize: 200,
                            ),

                            stepGranularity: .1,
                            minFontSize: 12,
                            // overflow: TextOverflow.ellipsis,
                            wrapWords: false,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RepaintBoundary(
                      child: _GetInTouchButton(controller: controller),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileImageFader extends StatelessWidget {
  final String profileImage = "assets/images/profile.jpg";

  ProfileImageFader({Key? key, required AnimationController controller})
      : fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
        super(key: key);

  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FullScreenWidget(
      alignment: const Alignment(0, -.4),
      maxSize: size,
      child: Image.asset(
        profileImage,
        opacity: fadeAnimation,
      ),
    );
  }
}

class _GetInTouchButton extends StatelessWidget {
  _GetInTouchButton({Key? key, required AnimationController controller})
      : opacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(.4, .75, curve: Curves.easeInCirc),
          ),
        ),
        scale = Tween<double>(begin: .85, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(.6, 1, curve: Curves.bounceOut),
          ),
        ),
        super(key: key);

  final Animation<double> opacity;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline1;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          const email = Email(
            mailTo: reikoEmail,
            bodyContent: "Hey Reiko, i'm contacting you from your website.",
            subject: "Contact",
            person: "you@gmail.com",
          );

          LinkService.sendEmail(email);
        },
        child: CustomLinkWidget(
          uri: LinkService.getUri(bodyMailText: "cc:reikodeveloper@gmail.com"),
          child: AnimatedBuilder(
            animation: opacity,
            builder: (context, child) {
              return Transform.scale(
                scale: scale.value,
                child: child!,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  heightFactor: .4,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: FadeTransition(
                      opacity: opacity,
                      child: Icon(
                        Icons.arrow_back,
                        textDirection: TextDirection.rtl,
                        color: style!.color!,
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.contain,
                  child: FadeTransition(
                    opacity: opacity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: style.color!, width: 2),
                        ),
                      ),
                      child: Text(
                        getInTouch,
                        style: style,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RevealingTextAnimation extends SingleChildRenderObjectWidget {
  const RevealingTextAnimation({
    super.key,
    required Widget child,
    required this.totalRows,
    required this.animValue,
    required this.textSize,
  }) : super(child: child);

  final int? totalRows;
  final double animValue;
  final Size textSize;

  @override
  RenderObject createRenderObject(context) {
    return _RevealingTextRender()
          ..totalRows = totalRows ?? 0
          ..animValue = animValue
          ..textSize = textSize
        //
        ;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RevealingTextRender renderObject) {
    final render = renderObject;
    render
          ..totalRows = totalRows ?? 0
          ..animValue = animValue
          ..textSize = textSize
        //
        ;

    super.updateRenderObject(context, render);
  }
}

class _RevealingTextRender extends RenderProxyBox {
  _RevealingTextRender();
  int _totalRows = 0;

  double _animValue = 0;

  Size _textSize = Size.zero;

  set totalRows(int newVal) {
    if (_totalRows == newVal) return;
    _totalRows = newVal;
    markNeedsPaint();
  }

  set animValue(double newVal) {
    if (newVal == _animValue) return;
    _animValue = newVal;
    markNeedsPaint();
  }

  set textSize(Size newVal) {
    if (newVal == _textSize) return;
    _textSize = newVal;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_animValue == 0 || _textSize == Size.zero || _totalRows == 0) return;

    final rect = offset & _textSize;

    context.canvas.saveLayer(rect, Paint());
    context.paintChild(child!, offset);

    final opaqueRowsFraction = _totalRows * _animValue;
    final opaqueRows = opaqueRowsFraction.toInt();
    if (opaqueRows > 0) {
      context.canvas.drawRect(
        offset &
            Size(_textSize.width, _textSize.height / _totalRows * opaqueRows),
        Paint()
          ..color = Colors.white
          ..blendMode = BlendMode.dstIn,
      );
    }

    final fadePainterOffset = Offset(
        offset.dx, offset.dy + _textSize.height / _totalRows * opaqueRows);

    final rowHeight = _textSize.height / _totalRows;

    final revealingRect = fadePainterOffset & Size(_textSize.width, rowHeight);

    final leftLimit = opaqueRowsFraction - opaqueRows;

    final rightLimit = (leftLimit + .1).clamp(0.0, 1.0);

    context.canvas.drawRect(
      revealingRect,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.green,
            Colors.green,
            Colors.red.withOpacity(0),
            Colors.red.withOpacity(0),
          ],
          stops: [0, leftLimit, rightLimit, 1],
        ).createShader(revealingRect)
        ..blendMode = BlendMode.dstIn
      //
      ,
    );

    final fadedRows = _totalRows - opaqueRows;

    if (fadedRows == 0) return;

    final fadedRectOffset =
        Offset(offset.dx, offset.dy + rowHeight * (opaqueRows + 1));

    // context.canvas
    //     .drawCircle(fadedRectOffset, 5, Paint()..color = Colors.green);

    final fadedRect =
        fadedRectOffset & Size(_textSize.width, rowHeight * fadedRows);
    context.canvas.drawRect(
      fadedRect,
      Paint()
        ..color = const Color(0x00000000)
        ..blendMode = BlendMode.dstIn
      //
      ,
    );

    context.canvas.restore();
  }
}
