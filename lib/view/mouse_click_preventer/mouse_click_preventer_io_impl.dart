import 'dart:async';

import 'package:reikodev_website/view/mouse_click_preventer/base_mouse_click_preventer.dart';

class MouseClickPreventer extends BaseMouseClickPreventer {
  @override
  StreamSubscription<dynamic>? listen(isShowingCopyMenu) => null;
}
