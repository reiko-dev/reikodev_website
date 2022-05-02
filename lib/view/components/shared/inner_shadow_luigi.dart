import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class InnerShadowLuigi extends SingleChildRenderObjectWidget {
  const InnerShadowLuigi({
    Key? key,
    required this.color,
    required this.blur,
    this.offset = Offset.zero,
    required Widget child,
  }) : super(key: key, child: child);

  final Color color;
  final double blur;
  final Offset offset;

  @override
  RenderInnerShadow createRenderObject(BuildContext context) {
    final renderObject = RenderInnerShadow();

    updateRenderObject(context, renderObject);

    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderInnerShadow renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..shadowOffset = offset;
  }
}

class RenderInnerShadow extends RenderProxyBox {
  RenderInnerShadow();

  @override
  bool get alwaysNeedsCompositing => child != null;

  late Color color;
  late double blur;
  late Offset shadowOffset;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      var layerPaint = Paint()..color = Colors.white;

      context.canvas.saveLayer(offset & size, layerPaint);
      context.paintChild(child!, offset);
      var shadowPaint = Paint()
        ..blendMode = ui.BlendMode.srcATop
        ..imageFilter = ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur)
        ..colorFilter =
            const ui.ColorFilter.mode(Colors.black, ui.BlendMode.srcIn);
      context.canvas.saveLayer(offset & size, shadowPaint);

      // Invert the alpha to compute inner part.
      var invertPaint = Paint()
        ..colorFilter = const ui.ColorFilter.matrix([
          1, 0, 0, 0, 0, //
          0, 1, 0, 0, 0,
          0, 0, 1, 0, 0,
          0, 0, 0, -1, 255,
        ]);
      context.canvas.saveLayer(offset & size, invertPaint);
      context.canvas.translate(shadowOffset.dx, shadowOffset.dy);
      context.paintChild(child!, offset);
      context.canvas.restore();
      context.canvas.restore();
      context.canvas.restore();
    }
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (child != null) visitor(child!);
  }
}
