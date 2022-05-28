import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/projects_controller.dart';
import 'package:reikodev_website/app/data/repository/projects_repository_web_impl.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(() {
      //

      return ProjectsController(
        //Instantiate different repositories depending on which platform you are running on.
        ProjectsRepositoryWebImpl(),
      );
    });
  }
}
