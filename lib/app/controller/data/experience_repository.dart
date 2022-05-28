//Repositório responsável pela entidade post !!
import 'package:reikodev_website/app/controller/entities/experience.dart';

//Interface to be used on the communication between
//the domain and data layers.
abstract class ExperienceRepository {
  //

  Future<bool> edit(Experience experience);

  Future<bool> delete(String experienceId);

  Future<List<Experience>> getAllExperiences();
}
