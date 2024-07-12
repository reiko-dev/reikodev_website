import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/projects_controller.dart';
import 'package:reikodev_website/app/controller/entities/project.dart';
import 'package:reikodev_website/app/ui/pages/page_template.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({required this.id, super.key});

  final String? id;

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  Project? project;

  @override
  void initState() {
    project = ProjectsController.i.projects
        .firstWhereOrNull((project) => project.id == widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PageTemplate(
      child: Center(
        child: SizedBox(
          width: size.width * .8,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DETAIL PAGE",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  project != null
                      ? project.toString()
                      : "Could not find the project with id ${widget.id} ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
