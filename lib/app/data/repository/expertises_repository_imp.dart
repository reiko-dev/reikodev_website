import 'package:reikodev_website/app/controller/data/habilities_repository.dart';
import 'package:reikodev_website/app/controller/entities/hability.dart';

class ExpertisesRepositoryImpl extends ExpertisesRepository {
  //
  @override
  Future<Map<ExpertiseType, List<Expertise>>> getAllExpertises() async {
    return {
      ExpertiseType.skills: [
        const Expertise(name: "Flutter"),
        const Expertise(name: "Firebase"),
        const Expertise(name: "Javascript"),
        const Expertise(name: "Dart"),
        const Expertise(name: "MongoDB"),
      ],
      ExpertiseType.softSkills: [
        const Expertise(name: "LEADERSHIP"),
        const Expertise(name: "TEAM MANAGEMENT"),
        const Expertise(name: "INTERCULTURAL & CROSS-FUNCTIONAL COMMUNICATION"),
      ],
      ExpertiseType.certificates: [
        const Expertise(name: "Flutter & Dart Developer", info: "Udemy"),
      ],
      ExpertiseType.idiomas: [
        const Expertise(name: "Portuguese", info: "Native Proficiency"),
        const Expertise(name: "English", info: "Limited Working Proficiency"),
      ],
    };
  }
}
