import 'dart:convert';

class GalleryResponse1 {
  List<Datum> data;

  GalleryResponse1({
    this.data,
  });

  factory GalleryResponse1.fromRawJson(String str) => GalleryResponse1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GalleryResponse1.fromJson(Map<String, dynamic> json) => GalleryResponse1(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  List<Content> content;
  int year;

  Datum({
    this.content,
    this.year,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    content: json["content"] == null ? null : List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    year: json["year"] == null ? null : json["year"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? null : List<dynamic>.from(content.map((x) => x.toJson())),
    "year": year == null ? null : year,
  };
}

class Content {
  int month;
  List<String> imageFilenames;

  Content({
    this.month,
    this.imageFilenames,
  });

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    month: json["month"] == null ? null : json["month"],
    imageFilenames: json["imageFilenames"] == null ? null : List<String>.from(json["imageFilenames"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "month": month == null ? null : month,
    "imageFilenames": imageFilenames == null ? null : List<dynamic>.from(imageFilenames.map((x) => x)),
  };
}
