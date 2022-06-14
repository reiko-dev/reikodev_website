import 'package:flutter/material.dart';
import 'package:reikodev_website/app/controller/link_service.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';
import 'package:reikodev_website/app/ui/widgets/custom_link_widget.dart';

class OnHoverAnimated extends StatefulWidget {
  const OnHoverAnimated({
    Key? key,
    required this.bottomText,
    required this.buttonText,
    required this.url,
    required this.asset,
  }) : super(key: key);

  final String buttonText;
  final String bottomText;
  final String asset;
  final String url;

  @override
  createState() => _OnHoverAnimatedState();
}

class _OnHoverAnimatedState extends AnimatedState<OnHoverAnimated> {
  @override
  void initState() {
    super.initState();
    initController(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 300),
    );
  }

  void onEnter(PointerEvent e) {
    controller.forward(from: 0);
  }

  void onExit(PointerEvent e) {
    controller.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          child: _VisualTextsAnimation(
            buttonText: widget.buttonText,
            bottomText: widget.bottomText,
            url: widget.url,
            controller: controller,
            asset: widget.asset,
          ),
        ),
      ),
    );
  }
}

class _VisualTextsAnimation extends StatelessWidget {
  _VisualTextsAnimation({
    Key? key,
    required this.buttonText,
    required this.bottomText,
    required AnimationController controller,
    required this.url,
    required this.asset,
  })  : txtFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0, .9, curve: Curves.easeInCubic)),
        ),
        txtTranslateAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0, .9, curve: Curves.easeInCubic)),
        ),
        scaleImageAnimation = Tween<double>(begin: 1, end: 1.15).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0, 1, curve: Curves.easeInCubic)),
        ),
        blendColorAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0, 1, curve: Curves.easeInCubic)),
        ),
        super(key: key);

  final Animation<double> txtFadeAnimation;
  final Animation<double> txtTranslateAnimation;

  final Animation<double> scaleImageAnimation;
  final Animation<double> blendColorAnimation;

  final String buttonText;
  final String bottomText;
  final String url;

  final String asset;

  final Alignment imageAlignmentWhenCover = const Alignment(0, -.3);

  final bgColor = Colors.grey.shade400.withOpacity(.85);
  final txtColor = Colors.grey.shade900;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: scaleImageAnimation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4(
                      scaleImageAnimation.value, 0, 0, 0, //
                      0, scaleImageAnimation.value, 0, 0,
                      0, 0, 1, 0,
                      0, 0, 0, 1,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      asset,
                      fit: BoxFit.cover,
                      alignment: imageAlignmentWhenCover,
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                height: 70,
                child: AnimatedBuilder(
                  animation: txtFadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: txtFadeAnimation.value,
                      child: child!,
                    );
                  },
                  child: _CenteredButton(
                    bgColor: bgColor,
                    buttonText: buttonText,
                    txtColor: txtColor,
                    url: url,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: txtTranslateAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: txtFadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, 30 - (30 * txtTranslateAnimation.value)),
                    child: child!,
                  ),
                );
              },
              child: _BottomText(
                bgColor: bgColor,
                bottomText: bottomText,
                txtColor: txtColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenteredButton extends StatelessWidget {
  const _CenteredButton({
    Key? key,
    required this.bgColor,
    required this.buttonText,
    required this.txtColor,
    required this.url,
  }) : super(key: key);

  final Color bgColor;
  final String buttonText;
  final Color txtColor;
  final String url;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            LinkService.launchURL(url);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomLinkWidget(
                uri: LinkService.getUri(url: url),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Text(
                        buttonText.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: txtColor,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_sharp,
                      color: txtColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomText extends StatelessWidget {
  const _BottomText({
    Key? key,
    required this.bgColor,
    required this.bottomText,
    required this.txtColor,
  }) : super(key: key);

  final Color bgColor;
  final String bottomText;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: LayoutBuilder(builder: (context, bc) {
        return Container(
          height: bc.maxHeight * .1,
          width: bc.maxWidth,
          color: bgColor,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                bottomText.toUpperCase(),
                maxLines: 2,
                style: Theme.of(context).textTheme.button!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
