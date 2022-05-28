// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reikodev_website/app/routes/routes.dart';
import 'package:reikodev_website/app/ui/pages/about/about_page.dart';
import 'package:reikodev_website/app/ui/pages/home/home_page.dart';
import 'package:reikodev_website/app/ui/pages/projects/project_details_page.dart';
import 'package:reikodev_website/app/ui/pages/projects/projects_page.dart';
import 'package:reikodev_website/app/ui/pages/unknown_page.dart';
import 'package:reikodev_website/app/ui/pages/background/background_page.dart';

class Pages {
  static bool isFirstBuild = true;
  static final all = <GoRoute>[
    GoRoute(
        name: Routes.bgAnimation.name,
        path: Routes.bgAnimation.location,
        builder: (context, state) {
          final bgaContext = BGAnimator.of(context)?.bgAnimatorKey.currentState;

          if (bgaContext == null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => BGAnimator.of(context)!
                  .bgAnimatorKey
                  .currentState!
                  .animateFromStart(),
            );
          } else {
            bgaContext.animateFromStart();
          }

          return RepaintBoundary(
            child: BackgroundPage(),
          );
        },
        routes: [
          GoRoute(
              name: Routes.home.name,
              path: Routes.home.name,
              pageBuilder: (context, state) {
                return _transitionPage(
                  context,
                  state,
                  const HomePage(),
                );
              }),
          GoRoute(
            name: Routes.about.name,
            path: Routes.about.name,
            pageBuilder: (context, state) => _transitionPage(
              context,
              state,
              const AboutPage(),
            ),
          ),
          GoRoute(
            name: Routes.projects.name,
            path: Routes.projects.name,
            pageBuilder: (context, state) => _transitionPage(
              context,
              state,
              const ProjectsPage(),
            ),
            routes: [
              GoRoute(
                name: Routes.projectDetails.name,
                path: ':id',
                pageBuilder: (context, state) {
                  final id = state.params["id"];
                  return _transitionPage(
                    context,
                    state,
                    ProjectDetailsPage(id: id),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: Routes.unknown.name,
            path: "unknown",
            pageBuilder: (context, state) => _transitionPage(
              context,
              state,
              UnknownPage(state: state),
            ),
          )
        ]),
  ];

  static CustomTransitionPage<void> _transitionPage(
      context, GoRouterState state, Widget child) {
    if (state.location != Routes.bgAnimation.location) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isFirstBuild = false;
      });
    }
    return CustomTransitionPage<void>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      opaque: false,
      maintainState: false,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 1400),
      transitionsBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(a2),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  static final unknownPage = GoRoute(
    name: Routes.unknown.name,
    path: "unknown",
    pageBuilder: (context, state) => _transitionPage(
      context,
      state,
      UnknownPage(state: state),
    ),
  );
}
