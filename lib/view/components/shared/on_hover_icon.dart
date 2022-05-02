import 'package:flutter/material.dart';
import 'package:reikodev_website/view/components/shared/custom_link_widget.dart';

class OnHoverIcon extends StatefulWidget {
  const OnHoverIcon({
    Key? key,
    required this.iconData,
    this.mouseCursor = SystemMouseCursors.click,
    this.onClick,
    this.padding = EdgeInsets.zero,
    this.withDivider = false,
    this.linkText = "",
    this.onHoverColor,
  }) : super(key: key);

  final IconData iconData;

  ///The style of mouse cursor when hover.
  final MouseCursor mouseCursor;

  final Function? onClick;

  final EdgeInsets padding;

  final bool withDivider;

  final String linkText;
  final Color? onHoverColor;
  @override
  State<OnHoverIcon> createState() => _OnHoverIconState();
}

class _OnHoverIconState extends State<OnHoverIcon> {
  late final Color standardColor;
  Color? currentColor;
  bool isHovering = false;
  MouseCursor cursor = SystemMouseCursors.basic;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      standardColor = Theme.of(context).iconTheme.color!;
      currentColor = Theme.of(context).iconTheme.color!;
    });
  }

  void setIsHovering(bool isHovering) {
    if (isHovering == this.isHovering) return;

    this.isHovering = isHovering;

    if (isHovering) {
      currentColor = widget.onHoverColor ?? Theme.of(context).hoverColor;
      cursor = widget.mouseCursor;
    } else {
      cursor = SystemMouseCursors.basic;
      currentColor = standardColor;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.onClick != null) {
              widget.onClick!();
            }
          },
          child: MouseRegion(
            onHover: (_) => setIsHovering(true),
            onExit: (_) => setIsHovering(false),
            cursor: cursor,
            child: Padding(
              padding: widget.padding,
              child: widget.linkText.isNotEmpty
                  ? CustomLinkWidget.url(
                      url: widget.linkText,
                      child: Icon(
                        widget.iconData,
                        color: currentColor,
                      ),
                    )
                  : Icon(
                      widget.iconData,
                      color: currentColor,
                    ),
            ),
          ),
        ),
        if (widget.withDivider) const VerticalDivider(),
      ],
    );
  }
}
