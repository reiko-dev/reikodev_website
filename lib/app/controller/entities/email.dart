import 'package:freezed_annotation/freezed_annotation.dart';

part 'email.freezed.dart';
part 'email.g.dart';

@freezed
class Email with _$Email {
  const factory Email({
    required String mailTo,
    required String bodyContent,
    required String subject,
    required String person,
  }) = _Email;

  factory Email.fromJson(Map<String, Object?> json) => _$EmailFromJson(json);
}
