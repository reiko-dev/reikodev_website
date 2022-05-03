import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:reikodev_website/logic/action_intent.dart';
import 'package:reikodev_website/view/mouse_click_preventer/mouse_click_preventer_io_impl.dart'
    if (dart.library.html) 'package:reikodev_website/view/mouse_click_preventer/mouse_click_preventer_web_impl.dart';

class CustomSelectableText extends StatefulWidget {
  const CustomSelectableText(
    this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  final String text;

  ///If non-null, the style to use for this text.
  ///
  ///If the style's "inherit" property is true, the style will be merged with the closest enclosing [DefaultTextStyle]. Otherwise, the style will replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  @override
  State<CustomSelectableText> createState() => _CustomSelectableTextState();
}

class _CustomSelectableTextState extends State<CustomSelectableText> {
  final _gkey = GlobalKey();
  final focusNode = FocusNode();
  bool _isShowingCopyMenu = false;

  MouseCursor _cursor = SystemMouseCursors.basic;

  final List<Rect> _textRects = [];
  final List<Rect> _selectionRects = [];
  Rect _caretRect = Rect.zero;

  late int _selectionBaseOffset;

  TextSelection _textSelection = const TextSelection.collapsed(offset: -1);
  StreamSubscription<dynamic>? mouseStream;

  late Map<LogicalKeySet, Intent> _shortcutMap;
  late Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _updateAllTextRects();
    });

    mouseStream = MouseClickPreventer().listen(
      () => _isShowingCopyMenu,
    );

    focusNode.addListener(() {
      if (!focusNode.hasFocus && !_isShowingCopyMenu) {
        setState(() {
          _selectionRects.clear();
          _caretRect = Rect.zero;
        });
      }
    });

    _shortcutMap = <LogicalKeySet, Intent>{
      LogicalKeySet(
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.keyC,
      ): const ActionIntent.copy(),
      LogicalKeySet(LogicalKeyboardKey.keyP): const ActionIntent.paste(),
    };

    _actionMap = <Type, Action<Intent>>{
      ActionIntent: CallbackAction<ActionIntent>(onInvoke: _actionHandler)
    };
  }

  Object? _actionHandler(ActionIntent ai) async {
    switch (ai.type) {
      case ActionType.copy:
        final selectedText =
            widget.text.substring(_textSelection.start, _textSelection.end);

        Clipboard.setData(ClipboardData(text: selectedText));
        break;

      case ActionType.paste:
        await Clipboard.getData('text/plain');
    }
    return null;
  }

  @override
  dispose() {
    mouseStream?.cancel();
    super.dispose();
  }

  RenderParagraph? get _renderParagraph {
    return _gkey.currentContext?.findRenderObject() as RenderParagraph;
  }

  void _onPanStart(DragStartDetails details) {
    if (_renderParagraph == null) {
      return;
    }

    _selectionBaseOffset =
        _renderParagraph!.getPositionForOffset(details.localPosition).offset;

    _textSelection = TextSelection.collapsed(offset: _selectionBaseOffset);
    _updateSelectionDisplay();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_renderParagraph == null) return;

    final selectionExtentOffset =
        _renderParagraph!.getPositionForOffset(details.localPosition).offset;

    _textSelection = TextSelection(
      baseOffset: _selectionBaseOffset,
      extentOffset: selectionExtentOffset,
    );

    _updateSelectionDisplay();
  }

  void _onPanEnd(DragEndDetails details) {
    //TODO:
  }
  void _onPanCancel() {
    //TODO:
  }

  void _updateSelectionDisplay() {
    if (_renderParagraph == null) return;
    //compute selection rectangles
    final selectionRects = _computeRectsForSelection(_textSelection);

    //update caret display
    final caretOffset =
        _renderParagraph!.getOffsetForCaret(_textSelection.extent, Rect.zero);

    final caretHeight =
        _renderParagraph!.getFullHeightForCaret(_textSelection.extent);

    setState(() {
      _selectionRects
        ..clear()
        ..addAll(selectionRects);

      _caretRect = Rect.fromLTWH(
        caretOffset.dx - 1,
        caretOffset.dy,
        2,
        caretHeight ?? 0,
      );
    });
  }

  void _onMouseMove(event) {
    if (event is PointerHoverEvent) {
      if (_renderParagraph == null) return;

      final allTextRects = _computeRectsForSelection(
        TextSelection(baseOffset: 0, extentOffset: widget.text.length),
      );
      bool isOverText = false;
      for (final rect in allTextRects) {
        if (rect.contains(event.localPosition)) {
          isOverText = true;
        }
      }

      final newCursor =
          isOverText ? SystemMouseCursors.text : SystemMouseCursors.basic;

      if (newCursor != _cursor) {
        setState(() {
          _cursor = newCursor;
        });
      }
    }
  }

  void _updateAllTextRects() {
    setState(() {
      _textRects
        ..clear()
        ..addAll(_computeRectsForSelection(
          TextSelection(baseOffset: 0, extentOffset: widget.text.length),
        ));
    });
  }

  List<Rect> _computeRectsForSelection(TextSelection textSelection) {
    if (_renderParagraph == null) {
      return [];
    }
    final textBoxes = _renderParagraph!.getBoxesForSelection(textSelection);
    return textBoxes.map((e) => e.toRect()).toList();
  }

  void _showContextMenu(PointerDownEvent e) async {
    if (_selectionRects.isEmpty) return;

    final selectionRect = _selectionRects
        .reduce((value, element) => value.expandToInclude(element));

    if (!selectionRect.contains(e.localPosition)) {
      return;
    }

    if (e.buttons != kSecondaryButton) {
      _updateAllTextRects();
      return;
    }

    final render = _renderParagraph;
    if (render == null) return;

    _isShowingCopyMenu = true;
    final menuItem = await showMenu<int>(
      context: context,
      items: [
        const PopupMenuItem(
          child: Text('Copy'),
          value: 1,
        ),
      ],
      position: RelativeRect.fromSize(
        Rect.fromLTWH(e.position.dx, e.position.dy, 48, 48),
        MediaQuery.of(context).size,
      ),
    );
    _isShowingCopyMenu = false;
    final selectedText =
        widget.text.substring(_textSelection.start, _textSelection.end);

    switch (menuItem) {
      case 1:
        Clipboard.setData(ClipboardData(text: selectedText));
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Cut clicked'), behavior: SnackBarBehavior.floating));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: _onMouseMove,
      onPointerDown: (e) {
        _showContextMenu(e);
        focusNode.requestFocus();
      },
      child: MouseRegion(
        cursor: _cursor,
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          onPanCancel: _onPanCancel,
          child: FocusableActionDetector(
            actions: _actionMap,
            shortcuts: _shortcutMap,
            child: Focus(
              focusNode: focusNode,
              autofocus: true,
              child: RepaintBoundary(
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: _SelectionPainter(
                        color: Colors.blue,
                        rects: _selectionRects,
                        fill: true,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (rect) {
                        Rect? textsRect;
                        if (_selectionRects.isNotEmpty) {
                          textsRect = _selectionRects.reduce((value, element) =>
                              value.expandToInclude(element));
                        }

                        return const LinearGradient(colors: [
                          Colors.white,
                          Colors.white,
                        ], tileMode: TileMode.decal)
                            .createShader(textsRect ?? Rect.zero);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Text(
                        widget.text,
                        key: _gkey,
                        style: widget.style,
                      ),
                    ),
                    CustomPaint(
                      painter: _SelectionPainter(
                        color: Colors.white,
                        rects: [_caretRect],
                        fill: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionPainter extends CustomPainter {
  _SelectionPainter({
    required this.color,
    required this.fill,
    required this.rects,
  });
  final Color color;
  final List<Rect> rects;
  final bool fill;

  @override
  void paint(Canvas canvas, Size size) {
    if (rects.isEmpty) return;
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke;

    for (Rect rect in rects) {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter oldDelegate) => true;
}
