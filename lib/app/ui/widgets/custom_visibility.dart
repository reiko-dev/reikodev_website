import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VisibilityDetails {
  VisibilityDetails(this.visibleBounds, this.visibleFraction);

  Rect visibleBounds;
  double visibleFraction;

  @override
  bool operator ==(Object other) {
    return (other is VisibilityDetails) &&
        other.visibleBounds == visibleBounds &&
        other.visibleFraction == visibleFraction;
  }

  @override
  String toString() {
    return "VisibilityDetailsl(visible bounds: $visibleBounds, visible fraction: $visibleFraction)";
  }

  @override
  int get hashCode => visibleBounds.hashCode ^ visibleFraction.hashCode;
}

class CustomVisibility extends SingleChildRenderObjectWidget {
  const CustomVisibility({
    super.key,
    required this.onVisibilityChanged,
    required super.child,
  });

  final void Function(VisibilityDetails vd) onVisibilityChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = _VisibilityRender();

    updateRenderObject(context, renderObject);

    return renderObject;
  }

  void onVisibilityChangedCall(VisibilityDetails vd) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onVisibilityChanged(vd);
    });
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _VisibilityRender renderObject) {
    renderObject
      ..onVisibilityChanged = onVisibilityChangedCall
      ..fullSize = MediaQuery.of(context).size;
  }
}

class _VisibilityRender extends RenderProxyBox {
  double _percent = 0;
  late Size fullSize;
  late void Function(VisibilityDetails vd) onVisibilityChanged;
  VisibilityDetails? _lastDetails;

  void updateCurrentNodePosition(Offset offset) {
    if (offset.dy > fullSize.height) {
      _percent = 0;
    } else {
      final a = fullSize.height - offset.dy;
      _percent = a / size.height;
      _percent = _percent > 1 ? 1 : _percent;
    }

    assert(_percent >= 0, "visible fraction value can't be lower than 0");
    assert(_percent <= 1, "visible fraction value can't be greater than 1");

    final newDetails = VisibilityDetails(offset & size, _percent);

    if (newDetails.visibleFraction != _lastDetails?.visibleFraction) {
      _lastDetails = newDetails;
      onVisibilityChanged(_lastDetails!);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(child != null, "Visibility child can't be null.");
    context.paintChild(child!, offset);

    updateCurrentNodePosition(offset);
  }
}
