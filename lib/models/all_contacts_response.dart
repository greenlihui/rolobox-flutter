// To parse this JSON data, do
//
//     final allContactsResponse = allContactsResponseFromJson(jsonString);

import 'dart:convert';

class AllContactsResponse {
  List<Datum> data;

  AllContactsResponse({
    this.data,
  });

  factory AllContactsResponse.fromRawJson(String str) => AllContactsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllContactsResponse.fromJson(Map<String, dynamic> json) => AllContactsResponse(
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
  Group group;
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
    group: json["group"] == null ? null : Group.fromJson(json["group"]),
    datumId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "faces": faces == null ? null : faces.toJson(),
    "_id": id == null ? null : id,
    "group": group == null ? null : group.toJson(),
    "id": datumId == null ? null : datumId,
  };
}

class Faces {
  String avatar;
  List<String> list;

  Faces({
    this.avatar,
    this.list,
  });

  factory Faces.fromRawJson(String str) => Faces.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Faces.fromJson(Map<String, dynamic> json) => Faces(
    avatar: json["avatar"] == null ? null : json["avatar"],
    list: json["list"] == null ? null : List<String>.from(json["list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar == null ? null : avatar,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x)),
  };
}

class Group {
  String color;
  String id;
  String owner;
  String name;
  String groupId;

  Group({
    this.color,
    this.id,
    this.owner,
    this.name,
    this.groupId,
  });

  factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    color: json["color"] == null ? null : json["color"],
    id: json["_id"] == null ? null : json["_id"],
    owner: json["owner"] == null ? null : json["owner"],
    name: json["name"] == null ? null : json["name"],
    groupId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "color": color == null ? null : color,
    "_id": id == null ? null : id,
    "owner": owner == null ? null : owner,
    "name": name == null ? null : name,
    "id": groupId == null ? null : groupId,
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
