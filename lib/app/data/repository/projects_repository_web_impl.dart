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
    return [
      const Project(
        id: "0",
        name: "Memory Game",
        imageURL: "assets/images/projects/memory_game.png",
        responsabilities: "Developer/Designer",
        siteURL:
            "https://play.google.com/store/apps/details?id=com.reiko.memorygame",
      ),
      const Project(
        id: "1",
        name: "DFT Painter",
        imageURL: "assets/images/projects/dft.gif",
        responsabilities: "Developer/Designer/Vacation",
        siteURL: "https://dft-painter.web.app/",
      ),
      const Project(
        id: "2",
        name: "Reiko Website",
        imageURL: "assets/images/projects/website.png",
        responsabilities: "Developer/Designer",
        siteURL: "https://reiko-website.web.app/",
      ),
      const Project(
        id: "3",
        name: "Content creator",
        imageURL: "assets/images/projects/youtube.png",
        responsabilities: "Designer/Artist/Scripter",
        siteURL: "https://www.youtube.com/channel/UC5COqoQbE51V4S9vWPBopNw",
      ),
    ];
  }
}
