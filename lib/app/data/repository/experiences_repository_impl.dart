//Repositório responsável pela entidade post !!
//lembrando que cada entidade que persiste de alguma forma com o banco de dados, seja ela uma api
//ou sqlite deve possuir um repositório exclusivo
import 'package:reikodev_website/app/controller/data/experience_repository.dart';
import 'package:reikodev_website/app/controller/entities/experience.dart';

class ExperiencesRepositoryImpl extends ExperienceRepository {
  static const String basePath = "assets/images/experiences/";

  @override
  Future<bool> delete(String experienceId) async {
    return true;
  }

  @override
  Future<bool> edit(Experience experience) async {
    return true;
  }

  @override
  Future<List<Experience>> getAllExperiences() async {
    return [
      const Experience(
        id: "0",
        city: "Rio Branco, Brazil",
        imageURL: "${basePath}child.jpg",
        context:
            "Born in Rio Branco - Acre, Brazil, 5 months before the Brazilian soccer "
            "team won the 4th Mundial Championship in the USA.",
        date: "Fev. 1994",
      ),
      const Experience(
        id: "1",
        city: "Barretos, Brazil",
        imageURL: "${basePath}firstcomputer.jpg",
        context: "My parents bought our first computer",
        date: "Apr. 2007",
      ),
      const Experience(
        id: "2",
        city: "Rio Branco, Brazil",
        imageURL: "${basePath}ufac.jpg",
        context: "Graduted from the Federal University of Acre with a "
            "Bachelor's degree in Information Systems.",
        date: "Apr. 2017",
        moreInfo:
            "・Throught a University scholarship, me and a friend developed and delivered a mobile App "
            "(my first one!) with Java in July of 2015.\n\n"
            "・Bachelor thesis on the 'Processing Information about Pull Requests'.",
      ),
      const Experience(
        id: "3",
        city: "Plácido de Castro, Brazil",
        imageURL: "${basePath}teacher.jpg",
        context: "A Dom Moacir professor of the Systems Development Course",
        date: "Aug-Dec. 2018",
        moreInfo:
            "・For 4 months I was in the government program \"Dom Moacir\","
            " aimed at the technical training of high school students where I was a teacher (also called contributor) of the Systems Development Course",
      ),
      const Experience(
        id: "4",
        city: "Sorocaba, Brazil",
        imageURL: "${basePath}memorygame.jpg",
        context:
            "Launched the Memory Game by Reiko on the play store, using Flutter and Firebase",
        date: "Apr. 2022",
      ),
    ];
  }
}
