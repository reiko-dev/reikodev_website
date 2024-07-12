import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/projects_controller.dart';
import 'package:reikodev_website/app/ui/pages/page_template.dart';
import 'package:reikodev_website/app/ui/widgets/animated_state.dart';
import 'package:reikodev_website/app/ui/widgets/on_hover_animated.dart';
import 'package:reikodev_website/app/ui/widgets/title_widget.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends AnimatedState<ProjectsPage> {
  @override
  void initState() {
    initController(duration: const Duration(milliseconds: 1500));
    start();
    super.initState();
  }

  void start() async {
    await Future.delayed(const Duration(milliseconds: 550));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PageTemplate(
      child: Obx(() {
        if (ProjectsController.i.isLoading) {
          controller.stop();
          return SizedBox.fromSize(
            size: size,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }
        start();

        return Column(
          children: [
            TitleWidget(title: "My Work", controller: controller),
            Center(
              child: _MainGrid(
                key: const ValueKey("works-grid-key"),
                controller: controller,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _MainGrid extends StatelessWidget {
  _MainGrid({super.key, required AnimationController controller})
      : translateAnimation =
            Tween<Offset>(begin: const Offset(0, 100), end: Offset.zero)
                .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(.5, 1, curve: Curves.easeInExpo),
          ),
        ),
        opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(.5, 1, curve: Curves.easeInExpo),
          ),
        );

  final Animation<Offset> translateAnimation;
  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final projects = ProjectsController.i.projects;

    final itemsPadding = size.shortestSide * .015;

    return GridView.count(
      crossAxisCount: size.width < 720 ? 1 : 2,
      shrinkWrap: true,
      childAspectRatio: 1.56,
      padding: EdgeInsets.symmetric(
        horizontal: size.width < 720 ? size.width * .075 : 0,
      ),
      mainAxisSpacing: 20 + itemsPadding,
      crossAxisSpacing: 20 + itemsPadding,
      semanticChildCount: projects.length,
      physics: const BouncingScrollPhysics(),
      children: [
        ...List.generate(
          projects.length,
          (i) {
            final project = projects[i];

            return AnimatedBuilder(
              animation: translateAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: translateAnimation.value,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: child!,
                  ),
                );
              },
              child: OnHoverAnimated(
                bottomText: project.responsabilities,
                buttonText: project.name,
                asset: project.imageURL,
                url: project.siteURL,
              ),
            );
          },
        )
      ],
    );
  }
}
