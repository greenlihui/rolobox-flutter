// To parse this JSON data, do
//
//     final groupContactResponse = groupContactResponseFromJson(jsonString);

import 'dart:convert';

class GroupContactResponse {
  List<Datum> data;

  GroupContactResponse({
    this.data,
  });

  factory GroupContactResponse.fromRawJson(String str) => GroupContactResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupContactResponse.fromJson(Map<String, dynamic> json) => GroupContactResponse(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Name name;
  Occupation occupation;
  Faces faces;
  String id;
  List<Phone> phones;
  List<Email> emails;
  String datumId;
  String group;

  Datum({
    this.name,
    this.occupation,
    this.faces,
    this.id,
    this.phones,
    this.emails,
    this.datumId,
    this.group
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    occupation: json["occupation"] == null ? null : Occupation.fromJson(json["occupation"]),
    faces: json["faces"] == null ? null : Faces.fromJson(json["faces"]),
    id: json["_id"] == null ? null : json["_id"],
    phones: json["phones"] == null ? null : List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
    emails: json["emails"] == null ? null : List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
    datumId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "occupation": occupation == null ? null : occupation.toJson(),
    "faces": faces == null ? null : faces.toJson(),
    "_id": id == null ? null : id,
    "phones": phones == null ? null : List<dynamic>.from(phones.map((x) => x.toJson())),
    "emails": emails == null ? null : List<dynamic>.from(emails.map((x) => x.toJson())),
    "id": datumId == null ? null : datumId,
    "group": group == null ? null : group,
  };
}

class Email {
  String id;
  String label;
  String address;

  Email({
    this.id,
    this.label,
    this.address,
  });

  factory Email.fromRawJson(String str) => Email.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Email.fromJson(Map<String, dynamic> json) => Email(
    id: json["_id"] == null ? null : json["_id"],
    label: json["label"] == null ? null : json["label"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "label": label == null ? null : label,
    "address": address == null ? null : address,
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

class Occupation {
  String company;
  String position;

  Occupation({
    this.company,
    this.position,
  });

  factory Occupation.fromRawJson(String str) => Occupation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
    company: json["company"] == null ? null : json["company"],
    position: json["position"] == null ? null : json["position"],
  );

  Map<String, dynamic> toJson() => {
    "company": company == null ? null : company,
    "position": position == null ? null : position,
  };
}

class Phone {
  String id;
  String label;
  String number;

  Phone({
    this.id,
    this.label,
    this.number,
  });

  factory Phone.fromRawJson(String str) => Phone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    id: json["_id"] == null ? null : json["_id"],
    label: json["label"] == null ? null : json["label"],
    number: json["number"] == null ? null : json["number"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "label": label == null ? null : label,
    "number": number == null ? null : number,
  };
}
