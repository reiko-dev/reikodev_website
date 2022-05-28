import 'package:dartz/dartz.dart';
import 'package:reikodev_website/app/controller/data/projects_repository.dart';
import 'package:reikodev_website/app/controller/entities/project.dart';
import 'package:reikodev_website/app/error/custom_failure.dart';

class GetAllProjectsUsecase {
  final ProjectsRepository _projectsRepository;

  GetAllProjectsUsecase(this._projectsRepository);

  Future<Either<CustomFailure, List<Project>>> getAll() async {
    try {
      final projects = await _projectsRepository.getAllProjects();
      return right(projects);
    } catch (e) {
      return left(CustomFailure(FailureType.unknown));
    }
  }
}
