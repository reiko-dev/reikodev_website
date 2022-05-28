//Repositório responsável pela entidade post !!
import 'package:reikodev_website/app/controller/entities/project.dart';

//Interface to be used on the communication between
//the domain and data layers.
abstract class ProjectsRepository {
  //

  Future<bool> edit(Project project);

  Future<bool> delete(String projectId);

  Future<List<Project>> getAllProjects();
}
