import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/entities/experience.dart';
import 'package:reikodev_website/app/controller/experience_controller.dart';
import 'package:reikodev_website/app/ui/pages/about/timeline_item.dart';

class TimeLine extends StatelessWidget {
  const TimeLine({Key? key, this.spaceBetweenItems = 40}) : super(key: key);

  ///Vertical distance between TimeLineItems.
  final double spaceBetweenItems;

  final EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 0, vertical: 80);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _TimeLineRenderObjectWidget(
      horizontalAlignment: size.width < 720 ? 0 : .5,
      padding: padding,
      child: Center(
        child: Padding(
          padding: padding,
          child: Obx(
            () {
              List<Experience> experiences = ExperienceController.i.experiences;

              return ExperienceController.i.isLoading
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: experiences.length,
                      padding: size.width < 720
                          ? const EdgeInsets.only(left: 20)
                          : null,
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: i == experiences.length - 1
                                ? 0
                                : size.height * .13,
                          ),
                          child: TimeLineItem(
                            experience: experiences[i],
                            key: ValueKey("tl-item-key-${experiences[i].id}"),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _TimeLineRenderObjectWidget extends SingleChildRenderObjectWidget {
  const _TimeLineRenderObjectWidget({
    // super.key,
    super.child,
    this.padding = EdgeInsets.zero,
    required this.horizontalAlignment,
  })  : assert(
          horizontalAlignment >= 0,
          "horizontalAlignment must be >= 0 and <=1",
        ),
        assert(
          horizontalAlignment <= 1,
          "horizontalAlignment must be >= 0 and <=1",
        );

  ///Adds padding to the list of TimeLines widgets.
  final EdgeInsets padding;

  ///This value must be bettwen in the closed intervel [0 and 1].
  ///0 is aligned on the left and 1 is aligned on the right
  ///
  final double horizontalAlignment;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = _TimeLineRender();

    updateRenderObject(context, renderObject);

    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _TimeLineRender renderObject) {
    renderObject
      ..fullSize = MediaQuery.of(context).size
      ..horizontalAlignment = horizontalAlignment
      ..padding = padding;
  }
}

class _TimeLineRender extends RenderProxyBox {
  double percent = 0;
  double lineWidth = 3;
  Size? fullSize;
  late EdgeInsets padding;
  late double horizontalAlignment;

  void updateCurrentNodePosition(Offset offset) {
    assert(fullSize != null, "fullSize is null");

    if (offset.dy > fullSize!.height / 2) {
      percent = 0;
      return;
    }

    final a = fullSize!.height / 2 - offset.dy;
    percent = a / size.height;

    if (percent > 1) {
      percent = 1;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
    updateCurrentNodePosition(offset);

    final topCenter = Offset(size.width * horizontalAlignment, 0) + offset;

    double nodeCenterHeight = 0;

    if (size.height * percent < padding.top) {
      nodeCenterHeight = padding.top;
    } else {
      if (size.height * percent > size.height - padding.bottom) {
        nodeCenterHeight = size.height * percent - padding.bottom;
      } else {
        nodeCenterHeight = size.height * percent;
      }
    }

    final nodeCenter =
        Offset(size.width * horizontalAlignment, nodeCenterHeight) + offset;

    //Draws the grey line
    context.canvas.drawRect(
      Rect.fromCenter(
          center: topCenter + Offset(0, size.height / 2),
          width: lineWidth,
          height: size.height),
      Paint()..color = Colors.grey.shade800,
    );

    //Draws the shadows
    context.canvas.drawLine(
      topCenter,
      nodeCenter,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..shader = LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(1),
              Colors.white.withOpacity(1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.05, 1]).createShader(offset & size),
    );

    //Draws the white line
    context.canvas.drawLine(
      topCenter,
      nodeCenter,
      Paint()
        ..strokeWidth = lineWidth
        ..color = Colors.white,
    );

    context.canvas
        .drawCircle(nodeCenter, lineWidth + 6, Paint()..color = Colors.white);
    context.canvas
        .drawCircle(nodeCenter, lineWidth + 2, Paint()..color = Colors.black87);
  }
}
