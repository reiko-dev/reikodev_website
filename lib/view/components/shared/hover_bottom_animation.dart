import 'package:flutter/material.dart';

class HoverBottomAnimation extends StatefulWidget {
  const HoverBottomAnimation({
    Key? key,
    required this.text,
    this.onTap,
    this.style,
  }) : super(key: key);

  final TextStyle? style;
  final String text;
  final void Function()? onTap;

  @override
  State<HoverBottomAnimation> createState() => _HoverBottomAnimationState();
}

class _HoverBottomAnimationState extends State<HoverBottomAnimation>
    with SingleTickerProviderStateMixin {
  final gKey = GlobalKey();

  late final AnimationController _controller;
  bool stopAnimation = false;
  double width = 0;
  MouseCursor cursor = SystemMouseCursors.basic;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (width == 0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        width = gKey.currentContext?.size?.width ?? 0;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    _controller.value = 0;
    _controller.animateTo(.5);

    if (cursor != SystemMouseCursors.click) {
      setState(() {
        cursor = SystemMouseCursors.click;
      });
    }
  }

  void finishAnimation() {
    if (cursor != SystemMouseCursors.basic) {
      setState(() {
        cursor = SystemMouseCursors.basic;
      });
    }
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => startAnimation(),
        onExit: (_) => finishAnimation(),
        cursor: cursor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                widget.text,
                key: gKey,
                style: widget.style ?? Theme.of(context).textTheme.headline3,
              ),
            ),
            RepaintBoundary(
              child: CustomPaint(
                size: Size(width, 2),
                painter: _LinePainter(
                    _controller, Theme.of(context).hoverColor, 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter(this._controller, Color color, double thickness)
      : painter = Paint()
          ..color = color
          ..strokeWidth = thickness,
        super(repaint: _controller);
  final AnimationController _controller;
  final Paint painter;

  @override
  void paint(Canvas canvas, Size size) {
    if (_controller.value <= .5) {
      canvas.drawLine(
        const Offset(0, 0),
        Offset(_controller.value * size.width * 2, 0),
        painter,
      );
    } else {
      canvas.drawLine(
        Offset(_controller.value * size.width, 0),
        Offset(size.width, 0),
        painter,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
