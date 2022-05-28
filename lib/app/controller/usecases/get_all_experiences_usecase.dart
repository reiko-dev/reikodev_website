import 'package:dartz/dartz.dart';
import 'package:reikodev_website/app/controller/data/experience_repository.dart';
import 'package:reikodev_website/app/controller/entities/experience.dart';
import 'package:reikodev_website/app/error/custom_failure.dart';

class GetAllExperiencesUsecase {
  final ExperienceRepository _experiencesRepository;

  GetAllExperiencesUsecase(this._experiencesRepository);

  Future<Either<CustomFailure, List<Experience>>> getAll() async {
    try {
      final projects = await _experiencesRepository.getAllExperiences();
      return right(projects);
    } catch (e) {
      return left(CustomFailure(FailureType.unknown));
    }
  }
}
