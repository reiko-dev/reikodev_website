import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:reikodev_website/app/routes/app_page_routes.dart';
import 'package:reikodev_website/app/routes/routes.dart';
import 'package:reikodev_website/app/ui/pages/unknown_page.dart';

final router = GoRouter(
  redirect: (state) {
    if (Routes.isAValidLocation(state.location)) {
      return null;
    }

    return Routes.unknown.location;
  },
  initialLocation: Routes.home.location,
  routes: Pages.all,
  navigatorBuilder: (context, state, pageWidget) {
    return pageWidget;
  },
  errorPageBuilder: (context, state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: UnknownPage(state: state),
    );
  },
  urlPathStrategy: UrlPathStrategy.path,
  errorBuilder: (context, state) => UnknownPage(state: state),
);
