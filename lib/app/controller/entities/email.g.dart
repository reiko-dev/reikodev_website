// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Email _$$_EmailFromJson(Map<String, dynamic> json) => _$_Email(
      mailTo: json['mailTo'] as String,
      bodyContent: json['bodyContent'] as String,
      subject: json['subject'] as String,
      person: json['person'] as String,
    );

Map<String, dynamic> _$$_EmailToJson(_$_Email instance) => <String, dynamic>{
      'mailTo': instance.mailTo,
      'bodyContent': instance.bodyContent,
      'subject': instance.subject,
      'person': instance.person,
    };
