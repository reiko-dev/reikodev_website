import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends AnimatedState<ProfileImage> {
  late final Animation<double> translateAnim1;
  late final Animation<double> translateAnim2;
  late final Animation<double> opacityAnim;
  final group = AutoSizeGroup();

  @override
  void initState() {
    initController(duration: const Duration(milliseconds: 3000));

    opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, .5, curve: Curves.linear),
      ),
    );

    translateAnim1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(.3, .55, curve: Curves.fastOutSlowIn),
      ),
    );
    translateAnim2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.6, 1, curve: Curves.fastOutSlowIn),
      ),
    );
    Future.delayed(const Duration(milliseconds: 1750)).then(
      (value) => controller.forward(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme.headline1!.copyWith(
          fontSize: 200,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );

    return Center(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: OverflowBox(
          maxWidth: size.width,
          maxHeight: size.height,
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: AnimatedBuilder(
                  animation: opacityAnim,
                  builder: (context, child) {
                    return FadedWidget(
                      opacity: opacityAnim.value,
                      child: Image.asset(
                        "assets/images/profile/profile_grayscale.jpg",
                        opacity: opacityAnim,
                        filterQuality: FilterQuality.high,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (frame == null) {
                            return const SizedBox.shrink();
                          }

                          return child;
                        },
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, -.5),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: SizedBox(
                  width: size.width < 400 ? size.width : size.width * .7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .25,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRRect(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                    0,
                                    size.height *
                                        .3 *
                                        (1 - translateAnim1.value),
                                  ),
                                  child: child!,
                                );
                              },
                              child: BlendedWidget(
                                child: AutoSizeText(
                                  "I am\n"
                                          "Reiko\n"
                                      .toUpperCase(),
                                  group: group,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: style,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .25,
                        child: ClipRRect(
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  size.height * .3 * (1 - translateAnim2.value),
                                ),
                                child: child!,
                              );
                            },
                            child: BlendedWidget(
                              child: AutoSizeText(
                                "Developer.\n"
                                        "Creative.\n"
                                    .toUpperCase(),
                                group: group,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: style,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadedWidget extends SingleChildRenderObjectWidget {
  const FadedWidget({
    super.key,
    required super.child,
    required this.opacity,
  }) : assert(child != null);

  final double opacity;

  @override
  RenderObject createRenderObject(context) {
    return FadedWidgetRender(MediaQuery.of(context).size, opacity);
  }

  @override
  void updateRenderObject(
      BuildContext context, FadedWidgetRender renderObject) {
    renderObject
      ..opacity = opacity
      ..fullSize = MediaQuery.of(context).size;
  }
}

class FadedWidgetRender extends RenderProxyBox {
  FadedWidgetRender(this.fullSize, this.imageOpacity);

  Size fullSize;
  double imageOpacity;

  set opacity(double newVal) {
    if (imageOpacity == newVal) return;

    imageOpacity = newVal;
    markNeedsPaint();
  }

  double fractionVisible(Offset offset) {
    double fraction = 1;

    if (offset.dy + size.height <= 0) {
      fraction = 0;
    } else {
      fraction = (offset.dy + size.height) / size.height;

      if (fraction > 1) {
        fraction = 1;
      }
    }

    assert(
      fraction >= 0 && fraction <= 1,
      "fraction $fraction visible must be between 0 and 1",
    );
    return fraction;
  }

  @override
  void paint(context, offset) {
    final fraction = fractionVisible(offset);

    if (fraction == 0) return;

    context.canvas.saveLayer(Offset.zero & fullSize, Paint());
    context.paintChild(child!, const Offset(0, 0));

    context.canvas.drawRect(
      Offset.zero & fullSize,
      Paint()
        ..blendMode = BlendMode.dstATop
        ..shader = LinearGradient(
          colors: [Colors.black.withOpacity(imageOpacity), Colors.transparent],
          begin: Alignment(0, -1.5 - (1 - fraction)),
          end: Alignment(0, fraction - (1 - fraction)),
          stops: const [.65, 1],
        ).createShader(
          Offset.zero & fullSize,
        ),
    );

    context.canvas.restore();
  }
}

class BlendedWidget extends SingleChildRenderObjectWidget {
  const BlendedWidget({
    super.key,
    required super.child,
  });

  @override
  RenderObject createRenderObject(context) {
    return BlendedWidgetRender(MediaQuery.of(context).size);
  }

  @override
  void updateRenderObject(
      BuildContext context, BlendedWidgetRender renderObject) {
    renderObject.fullSize = MediaQuery.of(context).size;
  }
}

class BlendedWidgetRender extends RenderProxyBox {
  BlendedWidgetRender(this.fullSize);
  Size fullSize;

  @override
  void paint(context, offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = BlendMode.plus
        ..color = Colors.white.withOpacity(.25),
    );

    context.paintChild(child!, offset);

    context.canvas.restore();
  }
}
