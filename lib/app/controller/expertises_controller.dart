import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/data/habilities_repository.dart';
import 'package:reikodev_website/app/controller/entities/hability.dart';
import 'package:reikodev_website/app/controller/usecases/get_all_habilities.dart';

class ExpertisesController extends GetxController {
  //
  final GetAllExpertisesUsecase _getAllExpertisesUsecase;
  static final ExpertisesController i = Get.find();

  ExpertisesController(ExpertisesRepository _repository)
      : _getAllExpertisesUsecase = GetAllExpertisesUsecase(_repository);

  @override
  void onInit() {
    super.onInit();
    _getAllExpertises();
  }

  final expertises = <ExpertiseType, List<Expertise>>{}.obs;

  final isLoading = false.obs;

  set expertisesList(value) => expertises.value = value;

  void _getAllExpertises() async {
    isLoading.value = true;
    final r = await _getAllExpertisesUsecase.getAll();

    r.fold(
      (l) => debugPrint("Error occurred $l"),
      (r) {
        expertises.clear();
        expertises.addAll(r);
      },
    );

    isLoading.value = false;
  }
}
