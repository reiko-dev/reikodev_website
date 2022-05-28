import 'dart:async';

import 'package:reikodev_website/app/ui/utils/mouse_preventer/base_mouse_click_preventer.dart';

class MouseClickPreventer extends BaseMouseClickPreventer {
  @override
  StreamSubscription<dynamic>? listen(isShowingCopyMenu) => null;
}
