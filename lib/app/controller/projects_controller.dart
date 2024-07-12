import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/data/projects_repository.dart';
import 'package:reikodev_website/app/controller/entities/project.dart';
import 'package:reikodev_website/app/controller/usecases/get_all_projects_usecase.dart';

class ProjectsController extends GetxController {
  //
  final GetAllProjectsUsecase _getAllProjectsUsecase;
  static final ProjectsController i = Get.find();

  ProjectsController(ProjectsRepository repository)
      : _getAllProjectsUsecase = GetAllProjectsUsecase(repository);

  @override
  void onInit() {
    super.onInit();
    _getAllProjects();
  }

  final projects = <Project>[].obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set projectsList(value) => projects.value = value;

  bool hasProject(String id) {
    return projects.any((element) => element.id == id);
  }

  void _getAllProjects() async {
    _isLoading.value = true;
    final r = await _getAllProjectsUsecase.getAll();

    r.fold(
      (l) => debugPrint("Error occurred $l"),
      (r) {
        projects.clear();
        projects.addAll(r);
      },
    );

    _isLoading.value = false;
  }
}
