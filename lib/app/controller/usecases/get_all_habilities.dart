import 'package:dartz/dartz.dart';
import 'package:reikodev_website/app/controller/data/habilities_repository.dart';
import 'package:reikodev_website/app/controller/entities/hability.dart';
import 'package:reikodev_website/app/error/custom_failure.dart';

class GetAllExpertisesUsecase {
  final ExpertisesRepository _habilitiesRepository;

  GetAllExpertisesUsecase(this._habilitiesRepository);

  Future<Either<CustomFailure, Map<ExpertiseType, List<Expertise>>>>
      getAll() async {
    try {
      final projects = await _habilitiesRepository.getAllExpertises();
      return right(projects);
    } catch (e) {
      return left(CustomFailure(FailureType.unknown));
    }
  }
}
