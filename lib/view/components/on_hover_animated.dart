import 'package:flutter/material.dart';
import 'package:reikodev_website/constants.dart';
import 'package:reikodev_website/logic/animated_state.dart';

class OnHoverAnimated extends StatefulWidget {
  const OnHoverAnimated({
    Key? key,
    this.color = const Color(0xFFF44336),
    required this.bottomText,
    required this.buttonText,
    this.asset,
  }) : super(key: key);

  final Color color;
  final String buttonText;
  final String bottomText;
  final String? asset;

  @override
  createState() => _OnHoverAnimatedState();
}

class _OnHoverAnimatedState extends AnimatedState<OnHoverAnimated> {
  @override
  void initState() {
    super.initState();
    init(
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
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: padding,
      child: AspectRatio(
        aspectRatio: 2,
        child: MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.height * .01),
            child: _VisualTextsAnimation(
              buttonText: widget.buttonText,
              bottomText: widget.bottomText,
              controller: controller,
              asset: widget.asset,
            ),
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
    this.asset,
  })  : fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0, .9, curve: Curves.easeInCubic)),
        ),
        translateAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0, .9, curve: Curves.easeInCubic)),
        ),
        super(key: key);

  final Animation<double> fadeAnimation;
  final Animation<double> translateAnimation;

  final String buttonText;
  final String bottomText;

  final String? asset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(asset ?? "assets/images/graphic_v2.png"),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: fadeAnimation.value,
              child: child!,
            );
          },
          child: FittedBox(
            fit: BoxFit.contain,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Text(
                          buttonText.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: translateAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(0, 30 - (30 * translateAnimation.value)),
                child: child!,
              ),
            );
          },
          child: Align(
            alignment: Alignment.bottomLeft,
            child: LayoutBuilder(builder: (context, bc) {
              return Container(
                height: bc.maxHeight * .1,
                width: bc.maxWidth,
                color: Colors.grey.shade300.withOpacity(.4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(bottomText.toUpperCase(), maxLines: 2),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
