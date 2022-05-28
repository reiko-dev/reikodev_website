import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String responsabilities,
    required String name,
    required String imageURL,
    required String siteURL,
  }) = _Project;

  factory Project.fromJson(Map<String, Object?> json) =>
      _$ProjectFromJson(json);
}
