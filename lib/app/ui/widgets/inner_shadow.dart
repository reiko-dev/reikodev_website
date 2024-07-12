import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    this.shadows = const <Shadow>[],
    super.child,
    this.radius = Radius.zero,
  });

  final List<Shadow> shadows;
  final Radius radius;
  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderInnerShadow renderObject) {
    renderObject
      ..shadows = shadows
      ..radius = radius;
  }
}

class RenderInnerShadow extends RenderProxyBox {
  late List<Shadow> shadows;
  late Radius radius;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    final bounds = offset & size;

    // context.canvas.drawRect(bounds, Paint()..color = Colors.white);
    context.canvas.saveLayer(bounds, Paint());
    context.paintChild(child!, offset);

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          bounds,
          radius,
        ),
      );

    context.canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(bounds),
        path,
      ),
      Paint()
        ..blendMode = BlendMode.dstATop
        ..color = Colors.black.withOpacity(0.2),
    );

    context.canvas.drawRect(
      bounds,
      Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke
        ..color = Colors.pink.withOpacity(0)
        ..blendMode = BlendMode.dstATop,
    );
    for (final shadow in shadows) {
      final shadowRect = bounds.inflate(shadow.blurSigma);
      final shadowPaint = Paint()
        ..blendMode = BlendMode.srcATop
        ..colorFilter = ColorFilter.mode(shadow.color, BlendMode.srcOut)
        ..imageFilter = ImageFilter.blur(sigmaX: 50, sigmaY: 50);
      context.canvas
        ..saveLayer(shadowRect, shadowPaint)
        ..translate(shadow.offset.dx, shadow.offset.dy);
      context.paintChild(child!, offset);
      context.canvas.restore();
    }

    context.canvas.restore();
  }
}
