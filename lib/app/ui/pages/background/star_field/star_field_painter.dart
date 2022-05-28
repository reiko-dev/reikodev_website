import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class StarFieldPainter extends CustomPainter {
  final List<Star> stars;
  final ui.Image glowImage;
  final Color smallStarsColor;

  StarFieldPainter(this.stars, this.smallStarsColor,
      {required this.glowImage, required AnimationController controller})
      : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    if (stars.isEmpty) return;

    final offset = Offset(size.width / 2, size.height / 2);

    var paint = Paint();

    for (var s in stars) {
      var scale = .1 + map(s.z, 0, size.width, s.size, 0);
      var sx = map(s.x / s.z, 0, 1, 0, size.width + offset.dx);
      var sy = map(s.y / s.z, 0, 1, 0, size.height + offset.dy);
      var time = DateTime.now().millisecondsSinceEpoch / 200;
      paint.color = smallStarsColor;
      // paint.color = Colors.red;
      var pos = Offset(sx, sy) + offset;

      canvas.drawCircle(pos, scale, paint);

      //The white elements will not get a glow decoration
      if (s.color != null) {
        var glowSizeX = scale * 6 + 2 * (sin(time * .5));
        var glowSizeY = scale * 6 + 2 * (cos(time * .75));
        var src = Rect.fromPoints(Offset.zero,
            Offset(glowImage.width.toDouble(), glowImage.height.toDouble()));
        var rect =
            Rect.fromCenter(center: pos, width: glowSizeX, height: glowSizeY);
        canvas.drawImageRect(
          glowImage,
          src,
          rect,

          paint
            ..blendMode = smallStarsColor == Colors.black
                //web incompatible with .dstOut,
                ? ui.BlendMode.darken
                : ui.BlendMode.luminosity,

          //
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double map(double value, double from1, double to1, double from2, double to2) {
    return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
  }
}

class Star {
  double x;
  double y;
  double z;
  double size = 1;
  double rotation = 0;
  Color? color;

  Star({this.x = 0, this.y = 0, this.z = 0});
}
