// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

class ContactResponse {
  Data data;

  ContactResponse({
    this.data,
  });

  factory ContactResponse.fromRawJson(String str) => ContactResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactResponse.fromJson(Map<String, dynamic> json) => ContactResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Name name;
  Occupation occupation;
  Faces faces;
  String id;
  List<Phone> phones;
  List<Email> emails;
  List<Social> socials;
  String group;
  String dataId;

  Data({
    this.name,
    this.occupation,
    this.faces,
    this.id,
    this.phones,
    this.emails,
    this.socials,
    this.group,
    this.dataId,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    occupation: json["occupation"] == null ? null : Occupation.fromJson(json["occupation"]),
    faces: json["faces"] == null ? null : Faces.fromJson(json["faces"]),
    id: json["_id"] == null ? null : json["_id"],
    phones: json["phones"] == null ? null : List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
    emails: json["emails"] == null ? null : List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
    socials: json["socials"] == null ? null : List<Social>.from(json["socials"].map((x) => Social.fromJson(x))),
    group: json["group"] == null ? null : json["group"],
    dataId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "occupation": occupation == null ? null : occupation.toJson(),
    "faces": faces == null ? null : faces.toJson(),
    "_id": id == null ? null : id,
    "phones": phones == null ? null : List<dynamic>.from(phones.map((x) => x.toJson())),
    "emails": emails == null ? null : List<dynamic>.from(emails.map((x) => x.toJson())),
    "socials": socials == null ? null : List<dynamic>.from(socials.map((x) => x.toJson())),
    "group": group == null ? null : group,
    "id": dataId == null ? null : dataId,
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
  String awsFaceId;
  String awsImageId;
  String awsCollectionId;
  String thumbnailImageFilename;

  ListElement({
    this.id,
    this.awsFaceId,
    this.awsImageId,
    this.awsCollectionId,
    this.thumbnailImageFilename,
  });

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"] == null ? null : json["_id"],
    awsFaceId: json["awsFaceId"] == null ? null : json["awsFaceId"],
    awsImageId: json["awsImageId"] == null ? null : json["awsImageId"],
    awsCollectionId: json["awsCollectionId"] == null ? null : json["awsCollectionId"],
    thumbnailImageFilename: json["thumbnailImageFilename"] == null ? null : json["thumbnailImageFilename"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "awsFaceId": awsFaceId == null ? null : awsFaceId,
    "awsImageId": awsImageId == null ? null : awsImageId,
    "awsCollectionId": awsCollectionId == null ? null : awsCollectionId,
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

class Social {
  String id;
  String platform;
  String username;

  Social({
    this.id,
    this.platform,
    this.username,
  });

  factory Social.fromRawJson(String str) => Social.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    id: json["_id"] == null ? null : json["_id"],
    platform: json["platform"] == null ? null : json["platform"],
    username: json["username"] == null ? null : json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "platform": platform == null ? null : platform,
    "username": username == null ? null : username,
  };
}
