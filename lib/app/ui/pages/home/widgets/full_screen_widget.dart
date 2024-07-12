import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FullScreenWidget extends SingleChildRenderObjectWidget {
  const FullScreenWidget({
    required super.child,
    super.key,
    required this.maxSize,
    required this.alignment,
  });

  final Size maxSize;

  ///The alignment to be used for fitting the canvas.
  final Alignment alignment;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = FullScreenWidgetRender();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, FullScreenWidgetRender renderObject) {
    renderObject
      ..maxSize = maxSize
      ..alignment = alignment;
  }
}

class FullScreenWidgetRender extends RenderProxyBox {
  FullScreenWidgetRender();
  Size? _maxSize;
  Alignment? _alignment;

  set alignment(Alignment alignment) {
    _alignment = alignment;
  }

  set maxSize(Size size) {
    _maxSize = size;
  }

  double get scaleToFitCanvas {
    double scaleToFitWidth = _maxSize!.width / size.width;
    double scaleToFitHeight = _maxSize!.height / size.height;

    return scaleToFitHeight > scaleToFitWidth
        ? scaleToFitHeight
        : scaleToFitWidth;
  }

  double get widthAlignment {
    if (_maxSize!.height < size.height) {
      return 0;
    }
    double newImageWidth = scaleToFitCanvas * size.width;
    double outsideBoundsWidth = newImageWidth - _maxSize!.width;

    double alignmentValue = _alignment!.x;

    if (_alignment!.x < -1) {
      alignmentValue = -1;
    } else {
      if (_alignment!.x > 1) {
        alignmentValue = 1;
      }
    }

    alignmentValue = (alignmentValue * .5) + .5;

    ///The alignment will be from 0 to -outsideBoundsHeight
    ///alignment =>
    ///top = 0
    ///center = -outsideBoundsHeight/2
    ///bottom = -outsideBoundsHeight
    ///
    return -outsideBoundsWidth * alignmentValue;
  }

  double get heightAlignment {
    ///A altura disponível é maior que o tamanho da foto? Se sim a altura vai ter que ser esticada,
    ///não aplicando o alinhamento no eixo vertical, somente no horizontal.
    if (_maxSize!.height > size.height) {
      return 0;
    }

    double newImageHeight = scaleToFitCanvas * size.height;
    double outsideBoundsHeight = newImageHeight - _maxSize!.height;

    double alignmentValue = _alignment!.y;

    if (_alignment!.y < -1) {
      alignmentValue = -1;
    } else {
      if (_alignment!.y > 1) {
        alignmentValue = 1;
      }
    }

    alignmentValue = (alignmentValue * .5) + .5;

    ///The alignment will be from 0 to -outsideBoundsHeight
    ///alignment =>
    ///top = 0
    ///center = -outsideBoundsHeight/2
    ///bottom = -outsideBoundsHeight
    ///
    return -outsideBoundsHeight * alignmentValue;
  }

  Offset get getAlignment {
    return Offset(widthAlignment, heightAlignment);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_maxSize == null) return;

    double scale = scaleToFitCanvas;
    Offset alignment = getAlignment;

    context.canvas.save();
    context.canvas.scale(scale);

    context.paintChild(
      super.child!,
      Offset(alignment.dx / scale, alignment.dy / scale),
    );
    context.canvas.restore();
  }
}
