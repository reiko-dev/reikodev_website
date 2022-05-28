// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get responsabilities => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  String get siteURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String responsabilities,
      String name,
      String imageURL,
      String siteURL});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  final Project _value;
  // ignore: unused_field
  final $Res Function(Project) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? responsabilities = freezed,
    Object? name = freezed,
    Object? imageURL = freezed,
    Object? siteURL = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      responsabilities: responsabilities == freezed
          ? _value.responsabilities
          : responsabilities // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: imageURL == freezed
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      siteURL: siteURL == freezed
          ? _value.siteURL
          : siteURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) then) =
      __$ProjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String responsabilities,
      String name,
      String imageURL,
      String siteURL});
}

/// @nodoc
class __$ProjectCopyWithImpl<$Res> extends _$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(_Project _value, $Res Function(_Project) _then)
      : super(_value, (v) => _then(v as _Project));

  @override
  _Project get _value => super._value as _Project;

  @override
  $Res call({
    Object? id = freezed,
    Object? responsabilities = freezed,
    Object? name = freezed,
    Object? imageURL = freezed,
    Object? siteURL = freezed,
  }) {
    return _then(_Project(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      responsabilities: responsabilities == freezed
          ? _value.responsabilities
          : responsabilities // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: imageURL == freezed
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      siteURL: siteURL == freezed
          ? _value.siteURL
          : siteURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Project implements _Project {
  const _$_Project(
      {required this.id,
      required this.responsabilities,
      required this.name,
      required this.imageURL,
      required this.siteURL});

  factory _$_Project.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectFromJson(json);

  @override
  final String id;
  @override
  final String responsabilities;
  @override
  final String name;
  @override
  final String imageURL;
  @override
  final String siteURL;

  @override
  String toString() {
    return 'Project(id: $id, responsabilities: $responsabilities, name: $name, imageURL: $imageURL, siteURL: $siteURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Project &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.responsabilities, responsabilities) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.imageURL, imageURL) &&
            const DeepCollectionEquality().equals(other.siteURL, siteURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(responsabilities),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(imageURL),
      const DeepCollectionEquality().hash(siteURL));

  @JsonKey(ignore: true)
  @override
  _$ProjectCopyWith<_Project> get copyWith =>
      __$ProjectCopyWithImpl<_Project>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectToJson(this);
  }
}

abstract class _Project implements Project {
  const factory _Project(
      {required final String id,
      required final String responsabilities,
      required final String name,
      required final String imageURL,
      required final String siteURL}) = _$_Project;

  factory _Project.fromJson(Map<String, dynamic> json) = _$_Project.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get responsabilities => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get imageURL => throw _privateConstructorUsedError;
  @override
  String get siteURL => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProjectCopyWith<_Project> get copyWith =>
      throw _privateConstructorUsedError;
}
