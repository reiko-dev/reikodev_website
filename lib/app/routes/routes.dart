///matchs the url /projects/idwhatever
bool _isProjectsRoute(String s) {
  final regex = RegExp(r'^/projects/\w*$');
  final hasMatch = regex.hasMatch(s);

  return hasMatch;
}

enum Routes {
  bgAnimation(name: "animation", location: "/"),
  home(name: "home", location: "/home"),
  projects(name: "projects", location: "/projects"),
  projectDetails(name: "project-details", location: "/projects/:id"),
  about(name: "about", location: "/about"),
  unknown(name: "unknown", location: "/unknown"),
  ;

  const Routes({required this.name, required this.location});

  final String name;
  final String location;

  static isAValidLocation(String location) {
    if (_isProjectsRoute(location)) {
      return true;
    }

    bool isValid = false;

    for (var route in Routes.values) {
      if (route.location == location) {
        isValid = true;
        break;
      }
    }

    return isValid;
  }
}
