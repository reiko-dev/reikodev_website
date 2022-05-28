// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'email.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Email _$EmailFromJson(Map<String, dynamic> json) {
  return _Email.fromJson(json);
}

/// @nodoc
mixin _$Email {
  String get mailTo => throw _privateConstructorUsedError;
  String get bodyContent => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get person => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailCopyWith<Email> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailCopyWith<$Res> {
  factory $EmailCopyWith(Email value, $Res Function(Email) then) =
      _$EmailCopyWithImpl<$Res>;
  $Res call({String mailTo, String bodyContent, String subject, String person});
}

/// @nodoc
class _$EmailCopyWithImpl<$Res> implements $EmailCopyWith<$Res> {
  _$EmailCopyWithImpl(this._value, this._then);

  final Email _value;
  // ignore: unused_field
  final $Res Function(Email) _then;

  @override
  $Res call({
    Object? mailTo = freezed,
    Object? bodyContent = freezed,
    Object? subject = freezed,
    Object? person = freezed,
  }) {
    return _then(_value.copyWith(
      mailTo: mailTo == freezed
          ? _value.mailTo
          : mailTo // ignore: cast_nullable_to_non_nullable
              as String,
      bodyContent: bodyContent == freezed
          ? _value.bodyContent
          : bodyContent // ignore: cast_nullable_to_non_nullable
              as String,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      person: person == freezed
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$EmailCopyWith<$Res> implements $EmailCopyWith<$Res> {
  factory _$EmailCopyWith(_Email value, $Res Function(_Email) then) =
      __$EmailCopyWithImpl<$Res>;
  @override
  $Res call({String mailTo, String bodyContent, String subject, String person});
}

/// @nodoc
class __$EmailCopyWithImpl<$Res> extends _$EmailCopyWithImpl<$Res>
    implements _$EmailCopyWith<$Res> {
  __$EmailCopyWithImpl(_Email _value, $Res Function(_Email) _then)
      : super(_value, (v) => _then(v as _Email));

  @override
  _Email get _value => super._value as _Email;

  @override
  $Res call({
    Object? mailTo = freezed,
    Object? bodyContent = freezed,
    Object? subject = freezed,
    Object? person = freezed,
  }) {
    return _then(_Email(
      mailTo: mailTo == freezed
          ? _value.mailTo
          : mailTo // ignore: cast_nullable_to_non_nullable
              as String,
      bodyContent: bodyContent == freezed
          ? _value.bodyContent
          : bodyContent // ignore: cast_nullable_to_non_nullable
              as String,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      person: person == freezed
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Email implements _Email {
  const _$_Email(
      {required this.mailTo,
      required this.bodyContent,
      required this.subject,
      required this.person});

  factory _$_Email.fromJson(Map<String, dynamic> json) =>
      _$$_EmailFromJson(json);

  @override
  final String mailTo;
  @override
  final String bodyContent;
  @override
  final String subject;
  @override
  final String person;

  @override
  String toString() {
    return 'Email(mailTo: $mailTo, bodyContent: $bodyContent, subject: $subject, person: $person)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Email &&
            const DeepCollectionEquality().equals(other.mailTo, mailTo) &&
            const DeepCollectionEquality()
                .equals(other.bodyContent, bodyContent) &&
            const DeepCollectionEquality().equals(other.subject, subject) &&
            const DeepCollectionEquality().equals(other.person, person));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(mailTo),
      const DeepCollectionEquality().hash(bodyContent),
      const DeepCollectionEquality().hash(subject),
      const DeepCollectionEquality().hash(person));

  @JsonKey(ignore: true)
  @override
  _$EmailCopyWith<_Email> get copyWith =>
      __$EmailCopyWithImpl<_Email>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EmailToJson(this);
  }
}

abstract class _Email implements Email {
  const factory _Email(
      {required final String mailTo,
      required final String bodyContent,
      required final String subject,
      required final String person}) = _$_Email;

  factory _Email.fromJson(Map<String, dynamic> json) = _$_Email.fromJson;

  @override
  String get mailTo => throw _privateConstructorUsedError;
  @override
  String get bodyContent => throw _privateConstructorUsedError;
  @override
  String get subject => throw _privateConstructorUsedError;
  @override
  String get person => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EmailCopyWith<_Email> get copyWith => throw _privateConstructorUsedError;
}
