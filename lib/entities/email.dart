class Email {
  Email({
    required this.mailTo,
    required this.bodyContent,
    required this.subject,
  });

  final String mailTo;
  final String subject;
  final String bodyContent;
}
