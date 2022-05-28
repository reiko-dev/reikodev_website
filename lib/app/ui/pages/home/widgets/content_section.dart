import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/projects_controller.dart';
import 'package:reikodev_website/app/controller/translations/translations.dart';
import 'package:reikodev_website/app/ui/widgets/on_hover_animated.dart';
import 'package:reikodev_website/main.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContentSection extends StatefulWidget {
  const ContentSection({super.key});

  @override
  State<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  void changeTheme({required bool isDark}) {
    if (isDarkThemeNotifier.value != isDark) {
      isDarkThemeNotifier.value = isDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contentsPadding = EdgeInsets.symmetric(
      horizontal: size.width * .1,
      vertical: size.height * .035,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * .05),
      child: VisibilityDetector(
        key: const ValueKey("VD-KEY-aasx"),
        onVisibilityChanged: (vd) {
          if (vd.visibleFraction >= .3) {
            changeTheme(isDark: false);
          } else {
            changeTheme(isDark: true);
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: size.height * .2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: contentsPadding,
                  child: AutoSizeText(
                    projects.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: size.width * .1,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (ProjectsController.i.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final projects = ProjectsController.i.projects;

              return Column(
                children: [
                  ...List.generate(
                    3,
                    (i) {
                      final project = projects[i];

                      return Padding(
                        padding: contentsPadding,
                        child: OnHoverAnimated(
                          bottomText: project.responsabilities,
                          buttonText: project.name,
                          asset: project.imageURL,
                          url: project.siteURL,
                        ),
                      );
                    },
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class FullBG extends SingleChildRenderObjectWidget {
  const FullBG({super.key, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BgPainterRender()..fullSize = context.mediaQuerySize;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant BgPainterRender renderObject) {
    renderObject.fullSize = context.mediaQuerySize;
    super.updateRenderObject(context, renderObject);
  }
}

class BgPainterRender extends RenderProxyBox {
  Color color = Colors.white;
  late Size fullSize;
  double _visibleFraction = 0;

  void updateVisibleFraction(Offset offset) {
    if (offset.dy > fullSize.height || (offset.dy + size.height) < 0) {
      _visibleFraction = 0;
    }

    final widgetBounds = offset & size;
    final screenBounds = Offset.zero & fullSize;
    final onScreenHeight = widgetBounds.intersect(screenBounds).size.height;

    _visibleFraction = (onScreenHeight / fullSize.height);
    if (_visibleFraction >= .5) {
      _visibleFraction = 1;
      return;
    } else {
      if (_visibleFraction < .2) {
        _visibleFraction = 0;
        return;
      }
    }

    _visibleFraction = Curves.ease.transformInternal(
      -.2 + (_visibleFraction * 2),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final blur = 10 - (10 * _visibleFraction);

    updateVisibleFraction(offset);

    layer = ImageFilterLayer(
      imageFilter: ImageFilter.blur(
        sigmaX: blur,
        sigmaY: blur,
        tileMode: TileMode.decal,
      ),
    );

    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..color = Colors.transparent
        ..blendMode = BlendMode.dstOut //
      ,
    );
    // context.pushLayer(
    //   layer!,
    //   paintChild,
    //   offset,
    //   childPaintBounds: offset & size,
    // );

    context.canvas.restore();
  }

  void paintChild(PaintingContext context, Offset offset) {
    final rect = offset & size;
    context.canvas.saveLayer(
      rect,
      Paint()
        ..color = const Color(0x44FF0000)
        ..blendMode = BlendMode.srcOver,
    );
    context.paintChild(child!, offset);
    context.canvas.drawRect(
      rect,
      Paint()
        ..color = const Color(0xFF000000).withOpacity(_visibleFraction)
        ..blendMode = BlendMode.dstIn
      //
      ,
    );
    context.canvas.restore();
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}
