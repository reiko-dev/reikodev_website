//Repositório responsável pela entidade post !!
import 'package:reikodev_website/app/controller/entities/hability.dart';

//Interface to be used on the communication between
//the domain and data layers.
abstract class ExpertisesRepository {
  Future<Map<ExpertiseType, List<Expertise>>> getAllExpertises();
}
