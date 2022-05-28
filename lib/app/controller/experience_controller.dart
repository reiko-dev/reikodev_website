import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/data/experience_repository.dart';
import 'package:reikodev_website/app/controller/entities/experience.dart';
import 'package:reikodev_website/app/controller/usecases/get_all_experiences_usecase.dart';

class ExperienceController extends GetxController {
  //
  final GetAllExperiencesUsecase _getAllExperienceUsecase;
  static final ExperienceController i = Get.find();

  ExperienceController(ExperienceRepository _repository)
      : _getAllExperienceUsecase = GetAllExperiencesUsecase(_repository);

  @override
  void onInit() {
    super.onInit();
    _getAllExperiences();
  }

  final experiences = <Experience>[].obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set experiencesList(value) => experiences.value = value;

  bool hasExperience(String id) {
    return experiences.any((element) => element.id == id);
  }

  void _getAllExperiences() async {
    _isLoading.value = true;
    final r = await _getAllExperienceUsecase.getAll();

    r.fold(
      (l) => debugPrint("Error occurred $l"),
      (r) {
        experiences.clear();
        experiences.addAll(r);
      },
    );

    _isLoading.value = false;
  }
}
