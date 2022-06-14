//Repositório responsável pela entidade post !!
//lembrando que cada entidade que persiste de alguma forma com o banco de dados, seja ela uma api
//ou sqlite deve possuir um repositório exclusivo
import 'package:reikodev_website/app/controller/data/projects_repository.dart';
import 'package:reikodev_website/app/controller/entities/project.dart';

class ProjectsRepositoryWebImpl extends ProjectsRepository {
  //

  @override
  Future<bool> delete(String projectId) async {
    return true;
  }

  @override
  Future<bool> edit(Project project) async {
    return true;
  }

  @override
  Future<List<Project>> getAllProjects() async {
    return const [
      Project(
        id: "0",
        name: "Memory Game",
        imageURL: "assets/images/projects/memorygame.jpg",
        responsabilities: "Developer/Designer",
        siteURL:
            "https://play.google.com/store/apps/details?id=com.reiko.memorygame",
      ),
      Project(
        id: "2",
        name: "General Designs",
        imageURL: "assets/images/projects/generalDesign.jpg",
        responsabilities: "Developer/Designer",
        siteURL: "https://general-design.web.app/",
      ),
      Project(
        id: "2",
        name: "Content creator",
        imageURL: "assets/images/projects/youtube.jpg",
        responsabilities: "Designer/Artist/Scripter",
        siteURL: "https://www.youtube.com/channel/UC5COqoQbE51V4S9vWPBopNw",
      ),
      Project(
        id: "3",
        name: "DFT Painter",
        imageURL: "assets/images/projects/dft.gif",
        responsabilities: "Developer/Designer/Vacation",
        siteURL: "https://dft-painter.web.app/",
      ),
    ];
  }
}
