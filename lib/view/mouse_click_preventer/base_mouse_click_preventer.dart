import 'dart:async';

abstract class BaseMouseClickPreventer {
  StreamSubscription<dynamic>? listen(bool Function() isShowingCopyMenu);
}
