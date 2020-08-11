// To parse this JSON data, do
//
//     final similarFaceResponse = similarFaceResponseFromJson(jsonString);

import 'dart:convert';

class SimilarFaceResponse {
  List<Datum> data;

  SimilarFaceResponse({
    this.data,
  });

  factory SimilarFaceResponse.fromRawJson(String str) => SimilarFaceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SimilarFaceResponse.fromJson(Map<String, dynamic> json) => SimilarFaceResponse(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Name name;
  Faces faces;
  String id;
  String group;
  String datumId;

  Datum({
    this.name,
    this.faces,
    this.id,
    this.group,
    this.datumId,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    faces: json["faces"] == null ? null : Faces.fromJson(json["faces"]),
    id: json["_id"] == null ? null : json["_id"],
    group: json["group"] == null ? null : json["group"],
    datumId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "faces": faces == null ? null : faces.toJson(),
    "_id": id == null ? null : id,
    "group": group == null ? null : group,
    "id": datumId == null ? null : datumId,
  };
}

class Faces {
  String avatar;
  List<ListElement> list;

  Faces({
    this.avatar,
    this.list,
  });

  factory Faces.fromRawJson(String str) => Faces.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Faces.fromJson(Map<String, dynamic> json) => Faces(
    avatar: json["avatar"] == null ? null : json["avatar"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar == null ? null : avatar,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  String id;
  String thumbnailImageFilename;

  ListElement({
    this.id,
    this.thumbnailImageFilename,
  });

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"] == null ? null : json["_id"],
    thumbnailImageFilename: json["thumbnailImageFilename"] == null ? null : json["thumbnailImageFilename"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "thumbnailImageFilename": thumbnailImageFilename == null ? null : thumbnailImageFilename,
  };
}

class Name {
  String first;
  String last;
  String full;

  Name({
    this.first,
    this.last,
    this.full,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    first: json["first"] == null ? null : json["first"],
    last: json["last"] == null ? null : json["last"],
    full: json["full"] == null ? null : json["full"],
  );

  Map<String, dynamic> toJson() => {
    "first": first == null ? null : first,
    "last": last == null ? null : last,
    "full": full == null ? null : full,
  };
}
