// To parse this JSON data, do
//
//     final friendInConversation = friendInConversationFromJson(jsonString);

import 'dart:convert';

class FriendInConversation {
  List<Datum> data;

  FriendInConversation({
    this.data,
  });

  factory FriendInConversation.fromRawJson(String str) => FriendInConversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FriendInConversation.fromJson(Map<String, dynamic> json) => FriendInConversation(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Status status;
  String id;
  String email;
  Profile profile;

  Datum({
    this.status,
    this.id,
    this.email,
    this.profile,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    id: json["_id"] == null ? null : json["_id"],
    email: json["email"] == null ? null : json["email"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status.toJson(),
    "_id": id == null ? null : id,
    "email": email == null ? null : email,
    "profile": profile == null ? null : profile.toJson(),
  };
}

class Profile {
  Name name;
  Occupation occupation;
  Faces faces;
  String id;
  List<Email> emails;
  List<Phone> phones;
  List<dynamic> socials;
  String profileId;

  Profile({
    this.name,
    this.occupation,
    this.faces,
    this.id,
    this.emails,
    this.phones,
    this.socials,
    this.profileId,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    occupation: json["occupation"] == null ? null : Occupation.fromJson(json["occupation"]),
    faces: json["faces"] == null ? null : Faces.fromJson(json["faces"]),
    id: json["_id"] == null ? null : json["_id"],
    emails: json["emails"] == null ? null : List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
    phones: json["phones"] == null ? null : List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
    socials: json["socials"] == null ? null : List<dynamic>.from(json["socials"].map((x) => x)),
    profileId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "occupation": occupation == null ? null : occupation.toJson(),
    "faces": faces == null ? null : faces.toJson(),
    "_id": id == null ? null : id,
    "emails": emails == null ? null : List<dynamic>.from(emails.map((x) => x.toJson())),
    "phones": phones == null ? null : List<dynamic>.from(phones.map((x) => x.toJson())),
    "socials": socials == null ? null : List<dynamic>.from(socials.map((x) => x)),
    "id": profileId == null ? null : profileId,
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
  List<dynamic> list;

  Faces({
    this.avatar,
    this.list,
  });

  factory Faces.fromRawJson(String str) => Faces.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Faces.fromJson(Map<String, dynamic> json) => Faces(
    avatar: json["avatar"] == null ? null : json["avatar"],
    list: json["list"] == null ? null : List<dynamic>.from(json["list"].map((x) => x)),
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

class Status {
  bool firstSignedIn;
  bool verified;
  bool locked;
  bool closed;

  Status({
    this.firstSignedIn,
    this.verified,
    this.locked,
    this.closed,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    firstSignedIn: json["firstSignedIn"] == null ? null : json["firstSignedIn"],
    verified: json["verified"] == null ? null : json["verified"],
    locked: json["locked"] == null ? null : json["locked"],
    closed: json["closed"] == null ? null : json["closed"],
  );

  Map<String, dynamic> toJson() => {
    "firstSignedIn": firstSignedIn == null ? null : firstSignedIn,
    "verified": verified == null ? null : verified,
    "locked": locked == null ? null : locked,
    "closed": closed == null ? null : closed,
  };
}
