// To parse this JSON data, do
//
//     final groupResponse = groupResponseFromJson(jsonString);

import 'dart:convert';

class GroupResponse {
  List<Datum> data;

  GroupResponse({
    this.data,
  });

  factory GroupResponse.fromRawJson(String str) => GroupResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupResponse.fromJson(Map<String, dynamic> json) => GroupResponse(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String color;
  String id;
  String owner;
  String name;
  int numContacts;
  String datumId;

  Datum({
    this.color,
    this.id,
    this.owner,
    this.name,
    this.numContacts,
    this.datumId,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    color: json["color"] == null ? null : json["color"],
    id: json["_id"] == null ? null : json["_id"],
    owner: json["owner"] == null ? null : json["owner"],
    name: json["name"] == null ? null : json["name"],
    numContacts: json["numContacts"] == null ? null : json["numContacts"],
    datumId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "color": color == null ? null : color,
    "_id": id == null ? null : id,
    "owner": owner == null ? null : owner,
    "name": name == null ? null : name,
    "numContacts": numContacts == null ? null : numContacts,
    "id": datumId == null ? null : datumId,
  };
}
