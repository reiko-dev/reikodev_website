class Expertise {
  final String name;
  final String? info;

  const Expertise({required this.name, this.info});
}

enum ExpertiseType {
  certificates("Certificates"),
  tools("Tools"),
  idiomas("Idiomas"),
  skills("Skills"),
  softSkills("Soft Skills");

  final String name;
  const ExpertiseType(this.name);
}
