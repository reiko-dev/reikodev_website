import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:reikodev_website/view/mouse_click_preventer/base_mouse_click_preventer.dart';

class MouseClickPreventer extends BaseMouseClickPreventer {
  @override
  StreamSubscription<dynamic> listen(bool Function() isShowingCopyMenu) {
    return document.onContextMenu.listen((event) {
      if (isShowingCopyMenu()) {
        event.preventDefault();
      }
    });
  }
}
