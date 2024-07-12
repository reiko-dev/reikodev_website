import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FloatingFlagText extends StatefulWidget {
  const FloatingFlagText({
    super.key,
    required this.child,
    required this.text,
  });

  final String text;
  final Widget child;

  @override
  State<FloatingFlagText> createState() => _FloatingFlagTextState();
}

class _FloatingFlagTextState extends AnimatedState<FloatingFlagText> {
  final frontWidgetSize = ValueNotifier<Size>(Size.zero);

  @override
  void initState() {
    initController(duration: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * .13,
            maxWidth: size.width * .7,
          ),
          child: SizedBox(
            height: size.height * .13,
            child: ValueListenableBuilder<Size>(
              valueListenable: frontWidgetSize,
              builder: (context, value, child) {
                return _FloatinBGRender(
                  frontWidgetBounds: value,
                  child: child,
                );
              },
              child: FittedBox(
                fit: BoxFit.contain,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: pi * .5 * controller.value,
                      origin: Offset(size.height * .0235, size.height * .0240),
                      alignment: const Alignment(-1, -1),
                      child: child!,
                    );
                  },
                  child: Text(
                    widget.text.toUpperCase(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Colors.white.withOpacity(.1),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
        VisibilityDetector(
          key: UniqueKey(),
          onVisibilityChanged: (vd) {
            if (frontWidgetSize.value != vd.size) {
              frontWidgetSize.value = vd.size;
            }
            final heightVisible = vd.visibleFraction * vd.size.height;

            if ((heightVisible > size.height / 2 || vd.visibleFraction >= 1) &&
                controller.status == AnimationStatus.dismissed) {
              controller.forward();
            }
          },
          child: widget.child,
        ),
      ],
    );
  }
}

class _FloatinBGRender extends SingleChildRenderObjectWidget {
  const _FloatinBGRender({
    // super.key,
    required this.frontWidgetBounds,
    required super.child,
  });

  final Size? frontWidgetBounds;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = _VisibilityRender();

    updateRenderObject(context, renderObject);

    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _VisibilityRender renderObject) {
    renderObject
      ..fullSize = MediaQuery.of(context).size
      ..frontWidgetSize = frontWidgetBounds;
  }
}

class _VisibilityRender extends RenderProxyBox {
  late Size fullSize;
  late Size? frontWidgetSize;
  bool _isVerticalOrientation = false;

  Offset getOffset(Offset initialOffset) {
    //Gives the offset to aligns the rotated text on the midline of the viewport
    final offset =
        Offset(initialOffset.dx, fullSize.height / 2 - size.width / 2);

    // if:
    // a) The rotated text is above the midline of the viewport, or
    // b) The frontwidget is not loaded yet
    // c) The total height of the frontWidget is smaller than the necessary height of the rotated text.
    //
    if (offset.dy < initialOffset.dy ||
        frontWidgetSize == null ||
        size.width > frontWidgetSize!.height) {
      return initialOffset;
    }

    //If the rotated text will overflow the height of the frontwidget than it is
    //anchored to the bottom of the frontwidget.
    //
    if (offset.dy + size.width > frontWidgetSize!.height + initialOffset.dy) {
      return initialOffset + Offset(0, frontWidgetSize!.height - size.width);
    }

    return offset;
  }

  void updateOrientation(Offset offset) {
    if (offset.dy <= fullSize.height / 2 && !_isVerticalOrientation) {
      _isVerticalOrientation = true;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(child != null, "Visibility child can't be null.");
    updateOrientation(offset);

    if (_isVerticalOrientation) {
      context.paintChild(child!, getOffset(offset));
    } else {
      context.paintChild(child!, offset);
    }
  }
}
