import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return RevealingTextRender()
          ..totalRows = totalRows ?? 0
          ..animValue = animValue
          ..textSize = textSize
        //
        ;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RevealingTextRender renderObject) {
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

class RevealingTextRender extends RenderProxyBox {
  RevealingTextRender();
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
