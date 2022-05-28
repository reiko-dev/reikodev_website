class Experience {
  const Experience({
    required this.id,
    required this.city,
    required this.date,
    required this.context,
    required this.imageURL,
    this.moreInfo,
  });

  final String id, city, date, context, imageURL;

  ///Could be a list of info, [List\<Info>]
  final String? moreInfo;

  factory Experience.fromJson(Map<String, Object?> json) {
    return Experience(
      id: json["id"] as String,
      context: json["context"] as String,
      city: json["city"] as String,
      date: json["date"] as String,
      imageURL: json["imageURL"] as String,
      moreInfo: json["moreInfo"] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "city": city,
      "date": date,
      "context": context,
      "moreInfo": moreInfo,
      "imageURL": imageURL,
    };
  }

  @override
  bool operator ==(Object other) {
    return (other is Experience &&
            other.id == id &&
            other.city == city &&
            other.context == context &&
            other.date == date &&
            other.imageURL == imageURL &&
            other.moreInfo == moreInfo //
        );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      city.hashCode ^
      context.hashCode ^
      date.hashCode ^
      imageURL.hashCode ^
      moreInfo.hashCode;
}
